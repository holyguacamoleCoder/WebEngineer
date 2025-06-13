package group.teachingmanagerbk.dto.member;

import group.teachingmanagerbk.vo.member.Student;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 查询学生信息的类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class QueryStudentParam {

    @Schema(description = "每页显示的记录数", example = "10")
    private Integer pageSize;       //页大小

    @Schema(description = "当前页码", example = "1")
    private Integer currentPage;    //第几页

    @Schema(description = "学生查询参数", example = "Student{name='张三'}")
    private Student param;           //学生的查询参数
}
