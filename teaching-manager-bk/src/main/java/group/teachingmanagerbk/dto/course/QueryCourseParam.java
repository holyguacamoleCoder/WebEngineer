package group.teachingmanagerbk.dto.course;

import group.teachingmanagerbk.vo.course.Course;
import lombok.Data;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class QueryCourseParam {

    @Schema(description = "每页显示的记录数", example = "10")
    private Integer pageSize;       //页大小

    @Schema(description = "当前页码", example = "1")
    private Integer currentPage;    //第几页

    @Schema(description = "课程查询参数", example = "Course{name='计算机科学导论'}")
    private Course param;           //课程的查询参数
}

