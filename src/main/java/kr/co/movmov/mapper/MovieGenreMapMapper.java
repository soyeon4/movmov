package kr.co.movmov.mapper;

import java.util.List;

import kr.co.movmov.vo.Genre;
import kr.co.movmov.vo.Movie;

public interface MovieGenreMapMapper {
	List<Genre> getGenresByMovieNo(int movieNo);
	
	List<Movie> getMoviesByGenreNo(int genreNo);
}
