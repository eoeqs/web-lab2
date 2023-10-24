package models;

import java.util.ArrayList;

public class Results {
    private final ArrayList<Point> points;

    public Results() {
        this.points = new ArrayList<>();
    }

    public void addPoint(Point point) {
        points.add(point);
    }

    public ArrayList<Point> getPoints() {
        return points;
    }

}
