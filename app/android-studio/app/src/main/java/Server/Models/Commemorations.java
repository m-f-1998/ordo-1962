package Server.Models;

import com.google.gson.annotations.SerializedName;

import java.util.List;
import java.util.UUID;

public class Commemorations {
    @SerializedName("id")
    private String id;

    @SerializedName("title")
    private String title;

    @SerializedName("rank")
    private int rank;

    @SerializedName("colors")
    private String colors;

    @SerializedName("propers")
    private List<Propers> propers;

    public Commemorations(String title, int rank, String colors, List<Propers> propers) {
        this.id = UUID.randomUUID().toString();
        this.title = title;
        this.rank = rank;
        this.colors = colors;
        this.propers = propers;
    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public int getRank() {
        return rank;
    }

    public String getColors() {
        return colors;
    }

    public List<Propers> getPropers() {
        return propers;
    }

    public boolean equals(Commemorations lhs, Commemorations rhs) {
        return lhs.id.equals(rhs.id);
    }

    public int hashCode() {
        return id.hashCode();
    }
}
