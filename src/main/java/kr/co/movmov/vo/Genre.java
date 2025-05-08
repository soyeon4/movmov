package kr.co.movmov.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Alias("Genre")
public class Genre {

   private int no;
   private String name;

}
