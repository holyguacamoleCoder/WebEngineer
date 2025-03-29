package group.teachingmanagerbk.dto.member;
import group.teachingmanagerbk.vo.member.Teacher;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QueryTeacherParam {

    @Schema(description = "每页显示的记录数", example = "10")
    private Integer pageSize;       //页大小

    @Schema(description = "当前页码", example = "1")
    private Integer currentPage;    //第几页

    @Schema(description = "教师查询参数", example = "Teacher{name='李四'}")
    private Teacher param;           //教师的查询参数
}

