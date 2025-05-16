package kr.co.movmov.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("Movie")
public class Movie {

   private int no;
   private String title;
   private String director;
   private String actor;
   private String country;
   private int length;
   private String rating;
   private String posterImagePath;
   private String plot;
   private int releaseYear;
   private List<Genre> genres;
   private int reviewCnt;
   private int wishCnt;
   private double avgStar;
}
