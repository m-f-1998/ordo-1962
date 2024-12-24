<?php

require_once  __DIR__ . '/db.php';

class Ordo {

    private $db;

    function __construct ( ) {

        $this->db = new DB ( );
        $this->db->Connect ( );

    }

    function GetOrdo ( $year ) {

        $res = array (
            "Year" => $year,
            "Ordo" => array (
                [], [], [], [], [], [],
                [], [], [], [], [], []
            )
        );

        $previousDay = NULL;

        foreach ( $this->GetCelebrations ( $year ) as $celebration ) {

            $propers = $this->GetPropers ( $celebration [ "feast" ], $celebration [ "date" ] );
            $date = new DateTime ( $celebration [ "date" ] );
            $current_index = $date->format ( "n" ) - 1;

            $celebration [ "title" ] = $this->EpiphanyResumed (  $celebration [ "title" ], $date );

            if ( $previousDay != $date->format ( "D d" ) ) { // New Celebration Day

                array_push ( $res [ "Ordo" ] [ $current_index ], array (
                    "date" => array (
                        "weekday" => $date->format ( "D" ),
                        "day" => $date->format ( "d" ),
                        "month" => $date->format ( "M" ),
                        "combined" => $date->format ( "d M Y" )
                    ),
                    "celebrations" => array ( ),
                    "season" => array (
                        "title" => $celebration [ "season" ],
                        "colors" => $celebration [ "s_colors" ]
                    ),
                    "fasting" => $this->GetFastingOptions ( $celebration [ "season" ], $celebration [ "id" ], $celebration [ "title" ], $date )
                ) );

                $previousDay = $date->format ( "D d" );

            }

            array_push ( $res [ "Ordo" ] [ $current_index ] [ count ( $res [ "Ordo" ] [ $current_index ] ) - 1 ] [ "celebrations" ],
                array (
                    "rank" => $celebration [ "rank" ],
                    "title" => $celebration [ "title" ],
                    "colors" => $celebration [ "colors" ],
                    "options" => $celebration [ "options" ],
                    "propers" => $this->GetProperTexts ( $propers, $celebration [ "title" ] ),
                    "commemorations" => $this->GetCommemorations ( $celebration [ "id" ] )
                )
            );

        }

        return $res;

    }

    private function GetCelebrations ( $year ) {

        return $this->db->Query (
            "SELECT c.`id`, c.`date`, c.`options`, c.`feast`,
                s.`title` as `season`, s.`colors` as `s_colors`,
                f.`title`, f.`rank`, f.`colors`
            FROM `Celebrations` c
                INNER JOIN `Season` s ON s.`id` = c.`season`
                INNER JOIN `Feast` f ON f.`id` = c.`feast`
            WHERE YEAR ( c.`date` )=:year ORDER BY c.`date`, c.`time` ASC",
            [ ":year" => $year ]
        );

    }

    private function GetPropers ( $feast, $date ) {

        $res = $this->db->Query (
            "SELECT pt.`category`, pt.`english`, pt.`latin`
                FROM `Propers` p
                    INNER JOIN `ProperText` pt ON p.`text` = pt.`ID`
                WHERE p.`feast`=:feast AND p.`date`=:date",
            [ ":feast" => $feast, ":date" => $date ]
        );

        return $res;

    }

    private function EpiphanyResumed ( $title, $date ) {

        if ( in_array ( $date->format ( "M" ), array ( "Nov", "Dec" ) ) && str_contains ( $title, "Epiphany" ) ) {

            return "(Resumed) " . $title;

        }

        return $title;

    }

    private function GetCommemorations ( $celebration ) {

        $results = $this->db->Query (
            "SELECT c.`id`, f.`title`, f.`rank`, f.`colors`,
                cp.`category`, pt.`english`, pt.`latin`
            FROM `CommemorationsV2` c
                LEFT JOIN `CommemorationPropers` cp ON cp.`commemoration` = c.`id`
                LEFT JOIN `ProperText` pt ON pt.`id` = cp.`text`
                INNER JOIN `Feast` f ON f.`id` = c.`feast`
            WHERE c.`celebration` = :celebration",
            [ ":celebration" => $celebration ]
        );

        $res = [ ];

        foreach ( $results as $row ) {

            $id = $row [ "id" ];

            if ( !isset ( $res [ $row [ "id" ] ] ) ) {

                $res [ $row [ "id" ] ] = [
                    "title" => $row [ "title" ],
                    "rank" => $row [ "rank" ],
                    "colors" => $row [ "colors" ],
                    "propers" => [ ]
                ];

            }

            if ( $row [ "category" ] !== null ) {

                $res [ $id ] [ "propers" ] [ ] = [
                    "title" => ucwords ( $row [ "category" ] ),
                    "english" => $row [ "english" ],
                    "latin" => $row [ "latin" ]
                ];

            }

        }

        return array_values ( $res );

    }

    private function GetProperTexts ( $propers, $title ) {

        $res = [ ];
        $unique_propers = [ ];

        if ( $title == "Good Friday" ) {

            return json_decode ( file_get_contents ( "./unique_propers/good_friday.json" ) );

        } else if ( $title == "Paschal Vigil" ) {

            return json_decode ( file_get_contents ( "./unique_propers/paschal_vigil.json" ) );

        } else if ( $title == "Mass of the Lord's Supper" ) {

            $unique_propers = json_decode ( file_get_contents ( "./unique_propers/mass_of_the_lords_supper.json" ), true );

        } else if ( $title == "Purification of the Blessed Virgin Mary" ) {

            $unique_propers = json_decode ( file_get_contents ( "./unique_propers/candlemas.json" ), true );

        } else if ( $title == "The Mass of the Chrism" ) {

            $unique_propers = json_decode ( file_get_contents ( "./unique_propers/chrism_mass.json" ), true );

        }

        if ( $propers && count ( $propers ) > 0 ) {

            $standard_indexes = [
                "introit" => 0, "collect" => 1, "first_lesson" => 2, "first_gradual" => 3,
                "first_collect" => 4, "second_lesson" => 5, "second_gradual" => 6, "second_collect" => 7,
                "third_lesson" => 8, "third_gradual" => 9, "third_collect" => 10, "fourth_lesson" => 11,
                "fourth_gradual" => 12, "fourth_collect" => 13, "fifth_lesson" => 14, "fifth_collect" => 15,
                "lesson" => 16, "gradual" => 17, "sequence" => 18, "gospel" => 19, "offertory" => 20,
                "secret" => 21, "preface" => 22, "communion" => 23, "postcommunion" => 24, 
                "prayer_over_the_people" => 25, "absolution" => 26
            ];

            usort ( $propers, function( $a, $b ) use ( $standard_indexes ) {
                $indexA = isset ( $standard_indexes [ $a [ "category" ] ] ) ?
                    $standard_indexes [ $a [ "category" ] ] : PHP_INT_MAX;
                $indexB = isset ( $standard_indexes [ $b [ "category" ] ] ) ?
                    $standard_indexes [ $b [ "category" ] ] : PHP_INT_MAX;
                return $indexA - $indexB;
            } );

            foreach ( $propers as $proper ) {

                array_push ( $res, array (
                    "title" => ucwords ( str_replace ( "_", " ", $proper [ "category" ] ) ),
                    "english" => $proper [ "english" ],
                    "latin" => $proper [ "latin" ],
                ) );

            }

            foreach ( $unique_propers as $proper ) {

                array_splice ( $res, $proper [ "index" ], 0, array ( array (
                    "title" => $proper [ "title" ],
                    "english" => $proper [ "english" ],
                    "latin" => $proper [ "latin" ],
                ) ) );

            }

        }

        return $res;

    }

    private function IsEmberDay ( $id, $title ) {

        if ( str_contains ( $title, "Ember " ) ) {

            return true;

        }

        foreach ( $this->db->Query (
            "SELECT f.`title` FROM `Commemorations` LEFT JOIN `Feast` f ON f.`id`=`feast` WHERE `celebration`=:id", [ ":id" => $id ]
        ) as $row ) {

            if ( str_contains ( $row [ "title" ], "Ember " ) ) {

                return true;

            }

        }

        return false;

    }

    private function GetFastingOptions ( $season, $id, $title, $date ) {

        $res = array ( );

        $ember = $this->IsEmberDay ( $id, $title );
        $is_sunday = $date->format ( "w" ) == 0;
        $is_friday = $date->format ( "w" ) == 5;
        $is_vigil_immac_conc = $date->format ( "d M" ) == "07 Dec";
        $is_vigil_pentecost = $title == "Vigil of Pentecost" && !$is_sunday;

        if ( $ember || $is_vigil_pentecost || ( in_array ( $season, array ( "Lent", "Passiontide" ) ) && !$is_sunday ) ) {

            array_push ( $res, "Fast Day" );

        }

        if ( ( !$is_friday && $ember ) || $is_vigil_pentecost  ) {

            array_push ( $res, "Partial Abstinence" );

        }

        if ( $is_friday || $is_vigil_immac_conc || $title == "Ash Wednesday" || ( $title == "Vigil of Christmas" && !$is_sunday ) ) {

            array_push ( $res, "Complete Abstinence" );

        }

        return $res;

    }

}
