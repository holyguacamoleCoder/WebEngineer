package group.teachingmanagerbk.dto.course;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class StudentSelectCourseData {

    @Schema(description = "学生选课的ID", example = "1001")
    private String coursesStudentsId;       //学生选课的id

    @Schema(description = "课程ID", example = "C101")
    private String courseId;                //课程id

    @Schema(description = "学生ID", example = "S001")
    private String studentId;               //学生id

    @Schema(description = "学生成绩", example = "88.5")
    private Float score;                    //学生成绩
}
