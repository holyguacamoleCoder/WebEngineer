package group.teachingmanagerbk.dto.application;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class CourseApplication {

    @Schema(description = "课程申请ID", example = "1")
    private String courseApplicationId;     //课程申请id

    @Schema(description = "教师ID", example = "T001")
    private String teacherId;               //教师id

    @Schema(description = "教师名称", example = "张三")
    private String teacherName;             //教师名称

    @Schema(description = "课程ID", example = "C101")
    private String courseId;                //课程id

    @Schema(description = "课程名称", example = "计算机科学导论")
    private String courseName;              //课程名称

    @Schema(description = "课程学分", example = "3")
    private String courseCredit;            //课程学分

    @Schema(description = "课程学时", example = "48")
    private String courseHour;              //课程学时

    @Schema(description = "授课时间", example = "每周一 10:00-12:00")
    private String courseTime;              //授课时间

    @Schema(description = "授课地点ID", example = "P001")
    private String coursePlaceId;           //授课地点id

    @Schema(description = "授课地点名称", example = "逸夫楼 429")
    private String coursePlaceName;         //授课地点名称

    @Schema(description = "课程描述", example = "这门课程介绍计算机科学的基础概念与技术。")
    private String courseDescription;       //课程描述

    @Schema(description = "审批状态ID", example = "1")
    private String courseExaminationId;     //审批状态id

    @Schema(description = "审批状态名称", example = "待审批")
    private String courseExaminationName;   //审批状态名称

    @Schema(description = "操作ID", example = "1")
    private String operationId;             //操作id

    @Schema(description = "操作名称", example = "新增")
    private String operationName;           //操作名称

    @Schema(description = "申请时间", example = "2025-03-29T10:00:00")
    private String dateTime;                //申请时间
}

