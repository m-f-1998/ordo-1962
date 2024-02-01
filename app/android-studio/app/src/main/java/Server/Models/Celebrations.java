package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class Celebrations {
    @SerializedName("id")
    private String id;

    @SerializedName("rank")
    private int rank;

    @SerializedName("title")
    private String title;

    @SerializedName("colors")
    private String colors;

    @SerializedName("options")
    private String options;

    @SerializedName("propers")
    private List<Propers> propers;

    @SerializedName("commemorations")
    private List<Commemorations> commemorations;

    public Celebrations(int rank, String title, String colors, String options, List<Propers> propers, List<Commemorations> commemorations) {
        this.id = UUID.randomUUID().toString();
        this.rank = rank;
        this.title = title;
        this.colors = colors;
        this.options = options;
        this.propers = propers;
        this.commemorations = commemorations;
    }

    public String getId() {
        return id;
    }

    public int getRank() {
        return rank;
    }

    public String getTitle() {
        return title;
    }

    public String getColors() {
        return colors;
    }

    public String getOptions() {
        return options;
    }

    public List<Propers> getPropers() {
        return propers;
    }

    public List<Commemorations> getCommemorations() {
        return commemorations;
    }

    public boolean equals(Celebrations lhs, Celebrations rhs) {
        return lhs.id.equals(rhs.id);
    }

    public int hashCode() {
        return id.hashCode();
    }

    private String formatProperString(Propers proper, String lang) {
        String res = "**" + String.valueOf(proper.getTitle()) + "**\n";
        res += proper.getPrayer(lang);
        return res;
    }

    public Map<String, String> getPropers(String lang) {
        Map<String, String> res = new HashMap<>();
        propers.forEach(proper -> {
            res.put(proper.getTitle(), formatProperString(proper, lang));
            int index = List.of("Collect", "Secret", "Postcommunion").indexOf(proper.getTitle());
            int idIndex = 2;
            for (Commemorations commem : commemorations) {
                if (commem.getPropers().size() > 0) {
                    res.put(idIndex + " " + proper.getTitle(), formatProperString(commem.getPropers().get(index), lang));
                    idIndex++;
                }
            }
        });
        return res;
    }
}
