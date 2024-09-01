<?php

require_once  __DIR__ . "/db.php";

class Ordo {

    private $db;

    function __construct ( ) {

        $this->db = new DB ( );
        $this->db->Connect ( );

    }

    function GetOrdo ( $year ) {

        $res = array (
            "Year" => $year,
            "Ordo" => array_fill ( 0, 12, [ ] )  // Fill array with 12 empty arrays for each month
        );

        $previousDay = null;
        $celebrations = $this->GetCelebrations ( $year );

        // Array to keep track of the last added day's reference to avoid lookups
        $lastAddedDay = null;
        $lastAddedDayIndex = -1;

        foreach ( $celebrations as $celebration ) {

            $date = new DateTime ( $celebration [ "date" ] );
            $currentMonthIndex = $date->format ( "n" ) - 1;
            $currentDayKey = $date->format ( "D d" );

            $uniquePropers = $this->loadUniquePropers ( $celebration [ "title" ] );

            // Prepare the celebration data
            $celebration [ "title" ] = $this->EpiphanyResumed ( $celebration [ "title" ], $date );
            $propers = $this->GetPropers ( $celebration [ "feast" ], $celebration [ "date" ] );
            $celebrationData = array (
                "rank" => $celebration [ "rank" ],
                "title" => $celebration [ "title" ],
                "colors" => $celebration [ "colors" ],
                "options" => $celebration [ "options" ],
                "propers" => $this->GetProperTexts ( $propers, $celebration [ "title" ], $uniquePropers ),
                "commemorations" => $this->GetCommemorations ( $celebration [ "id" ] )
            );

            // Check if this is a new day in the loop
            if ( $previousDay !== $currentDayKey ) {

                // Add new day entry
                $lastAddedDay = array (
                    "date" => array (
                        "weekday" => $date->format ( "D" ),
                        "day" => $date->format ( "d" ),
                        "month" => $date->format ( "M" ),
                        "combined" => $date->format ( "d M Y" )
                    ),
                    "celebrations" => array ( $celebrationData ), // Start with the current celebration
                    "season" => array (
                        "title" => $celebration [ "season" ],
                        "colors" => $celebration [ "s_colors" ]
                    ),
                    "fasting" => $this->GetFastingOptions ( $celebration [ "season" ], $celebration [ "id" ], $celebration [ "title" ], $date )
                );

                // Push this day into the Ordo structure
                $res [ "Ordo" ] [ $currentMonthIndex ] [ ] = $lastAddedDay;
                $lastAddedDayIndex = count ( $res [ "Ordo" ] [ $currentMonthIndex ] ) - 1;
                $previousDay = $currentDayKey;

            } else {

                // If it's the same day, just append the celebration to the last added day
                $res [ "Ordo" ] [ $currentMonthIndex ] [ $lastAddedDayIndex ] [ "celebrations" ] [ ] = $celebrationData;

            }

        }

        return $res;

    }

    private function loadUniquePropers ( $title ) {

        $uniquePropersFiles = [
            "Good Friday" => "good_friday.json",
            "Paschal Vigil" => "paschal_vigil.json",
            "Mass of the Lord's Supper" => "mass_of_the_lords_supper.json",
            "Purification of the Blessed Virgin Mary" => "candlemas.json",
            "The Mass of the Chrism" => "chrism_mass.json"
        ];

        $fileName = $uniquePropersFiles [ $title ] ?? null;

        if ( $fileName ) {

            return json_decode ( file_get_contents ( __DIR__ . "/unique_propers/" . $fileName ), true );

        }

        return [ ];
    
    }


    private function GetCelebrations ( $year ) {

        return $this->db->Query (
            "SELECT c.`id`, c.`date`, c.`options`,
                s.`title` as `season`, s.`colors` as `s_colors`,
                f.`title`, f.`rank`, f.`colors`, `feast`
                FROM `Celebrations` c
                LEFT JOIN `Season` s ON s.`id` = c.`season`
                LEFT JOIN `Feast` f ON f.`id` = c.`feast`
                WHERE YEAR ( c.`date` )=:year ORDER BY c.`date`, c.`time` ASC",
            [ ":year" => $year ]
        );

    }

    private function GetAllPropersForYear ( $year ) {

        return $this->db->Query (
            "SELECT * FROM `Propers` WHERE YEAR(`date`) = :year",
            [ ":year" => $year ]
        );

    }

    private function OrganizePropersByFeastAndDate ( $propersData ) {

        $organizedPropers = [ ];
        foreach ( $propersData as $proper ) {

            $key = $proper [ "feast" ] . "|" . $proper [ "date" ];
            $organizedPropers [ $key ] = $proper;

        }
        return $organizedPropers;

    }

    private $propersCache = [ ];

    private function GetPropers ( $feast, $date ) {

        // Construct the key used to access the organized propers data
        $key = $feast . "|" . $date;

        // Check if the propers data has already been loaded
        if ( empty ( $this->propersCache ) ) {

            $propersData = $this->GetAllPropersForYear ( ( new DateTime ( $date ) )->format ( "Y" ) );
            $this->propersCache = $this->OrganizePropersByFeastAndDate ( $propersData );

        }

        // Return the proper data if it exists
        return $this->propersCache [ $key ] ?? [ ];

    }

    private function EpiphanyResumed ( $title, $date ) {

        // Define constants for comparison
        $EPIPHANY = "Epiphany";
        $RESUMED_PREFIX = "(Resumed) ";
        $resumedMonths = [ "Nov", "Dec" ];

        // Get the month abbreviation
        $month = $date->format ( "M" );

        // Check if the month is in the resumed months and title contains "Epiphany"
        if ( in_array ( $month, $resumedMonths, true ) && stripos ( $title, $EPIPHANY ) !== false ) {

            return $RESUMED_PREFIX . $title;

        }

        return $title;

    }

    private function GetCommemorations ( $celebration ) {

        // Fetch all commemorations in one query
        $commemorations = $this->db->Query (
            "SELECT f.`title`, f.`rank`, f.`colors`, c.`collect`, c.`secret`, c.`postcommunion`
            FROM `Commemorations` c
            LEFT JOIN `Feast` f ON f.`id` = c.`feast`
            WHERE c.`celebration` = :celebration",
            [ ":celebration" => $celebration ]
        );

        // Early exit if no commemorations found
        if ( empty ( $commemorations ) ) {

            return [ ];

        }

        // Collect all ProperText IDs
        $properTextIds = [ ];
        foreach ( $commemorations as $commemoration ) {

            $properTextIds [ ] = $commemoration [ "collect" ];
            $properTextIds [ ] = $commemoration [ "secret" ];
            $properTextIds [ ] = $commemoration [ "postcommunion" ];

        }

        // Remove duplicates and sanitize array for SQL IN clause
        $properTextIds = array_unique ( $properTextIds );
        $idsPlaceholder = implode ( ",", array_fill ( 0, count ( $properTextIds ), "?" ) );

        // Fetch all propers in one query
        $propersQuery = $this->db->Query (
            "SELECT p.`id`, p.`category` as `title`, p.`english`, p.`latin`
            FROM `ProperText` p
            WHERE p.`id` IN ($idsPlaceholder)
            ORDER BY FIELD(p.`category`, 'collect', 'secret', 'postcommunion')",
            $properTextIds
        );

        // Map propers by their IDs for quick lookup
        $propersById = [ ];
        foreach ( $propersQuery as $proper ) {

            $proper [ "title" ] = ucwords ( $proper [ "title" ] );
            $propers_text = $proper;
            unset ( $propers_text [ "id" ] );
            $propersById [ $proper [ "id" ] ] = $propers_text;

        }

        $res = [ ];
        foreach ( $commemorations as $commemoration ) {

            $propers = [
                $propersById [ $commemoration [ "collect" ] ] ?? null,
                $propersById [ $commemoration [ "secret" ] ] ?? null,
                $propersById [ $commemoration [ "postcommunion" ] ] ?? null
            ];

            // Filter out any null values (in case of missing data)
            $propers = array_filter ( $propers );

            $res [ ] = [
                "title" => $commemoration [ "title" ],
                "rank" => $commemoration [ "rank" ],
                "colors" => $commemoration [ "colors" ],
                "propers" => $propers
            ];

        }

        return $res;

    }

    private function GetProperTexts ( $propers, $title, $uniquePropers = [ ] ) {

        $res = [ ];

        // Fetch all required proper texts in one query if there are propers
        if ( !empty ( $propers ) ) {

            $properTexts = $this->db->Query (
                "SELECT `id`, `category`, `english`, `latin` FROM `ProperText` WHERE `id` IN (" . implode ( ",", array_fill ( 0, count ( $propers ), "?" ) ) . ")",
                array_values ( $propers )
            );

            // Map the proper texts to a more accessible format
            $properTextsMap = [ ];
            foreach ( $properTexts as $proper ) {

                $properTextsMap [ $proper [ "id" ] ] = [
                    "title" => ucwords ( str_replace ( "_", " ", $proper [ "category" ] ) ),
                    "english" => $proper [ "english" ],
                    "latin" => $proper [ "latin" ],
                ];

            }

            // Add the proper texts to the result array
            foreach ( $propers as $properId ) {

                if ( isset ( $properTextsMap [ $properId ] ) ) {

                    $res [ ] = $properTextsMap [ $properId ];

                }

            }

        }

        // Insert the unique propers into the result array
        foreach ( $uniquePropers as $proper ) {

            $res [ ] = [
                "title" => $proper [ "title" ],
                "english" => $proper [ "english" ],
                "latin" => $proper [ "latin" ],
            ];

        }

        return $res;

    }

    private function IsEmberDay ( $id, $title ) {

        if ( str_contains ( $title, "Ember " ) ) {

            return true;

        }

        // Only query the database if the title does not already indicate an Ember Day
        $rows = $this->db->Query (
            "SELECT f.`title` FROM `Commemorations` 
            LEFT JOIN `Feast` f ON f.`id` = `feast` 
            WHERE `celebration` = :id",
            [ ":id" => $id ]
        );

        foreach ( $rows as $row ) {

            if ( str_contains ( $row [ "title" ], "Ember " ) ) {

                return true;

            }

        }

        return false;

    }

    private function GetFastingOptions ( $season, $id, $title, $date ) {

        $res = [ ];

        $ember = $this->IsEmberDay ( $id, $title );
        $dayOfWeek = $date->format ( "w" );
        $dayMonth = $date->format ( "d M" );

        $is_sunday = ( $dayOfWeek == 0 );
        $is_friday = ( $dayOfWeek == 5 );
        $is_vigil_immac_conc = ( $dayMonth == "07 Dec" );
        $is_vigil_pentecost = ( $title == "Vigil of Pentecost" && !$is_sunday );

        if ( $ember || $is_vigil_pentecost || ( in_array ( $season, [ "Lent", "Passiontide" ] ) && !$is_sunday ) ) {

            $res [ ] = "Fast Day";

        }

        if ( ( !$is_friday && $ember ) || $is_vigil_pentecost ) {

            $res [ ] = "Partial Abstinence";

        }

        if ( $is_friday || $is_vigil_immac_conc || $title == "Ash Wednesday" || ( $title == "Vigil of Christmas" && !$is_sunday ) ) {

            $res [ ] = "Complete Abstinence";

        }

        return $res;

    }

}
