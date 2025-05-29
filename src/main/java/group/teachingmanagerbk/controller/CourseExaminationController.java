package group.teachingmanagerbk.controller;

import group.teachingmanagerbk.dto.application.CourseApplication;
import group.teachingmanagerbk.service.CourseExaminationService;
import group.teachingmanagerbk.utils.ReturnResult.Result;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@RestController
@Tag(name = "数据审批接口")
public class CourseExaminationController {

    @Autowired
    CourseExaminationService courseExaminationService;

    //查询所有待审批的数据
    @GetMapping("/wait/examination")
    @Operation(summary = "查询所有待审批的数据", description = "查询所有处于待审批状态的课程申请数据")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "成功获取待审批数据"),
            @ApiResponse(responseCode = "0", description = "未找到待审批的数据")
    })
    public Result getWaitExamination(String examinationName) {
        ArrayList<CourseApplication> data = courseExaminationService.getWaitExamination(examinationName);
        return new Result().success(data);
    }

    //查询所有已审批的数据
    @GetMapping("/already/examination")
    @Operation(summary = "查询所有已审批的数据", description = "查询所有已审批状态的课程申请数据")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "成功获取已审批数据"),
            @ApiResponse(responseCode = "0", description = "未找到已审批的数据")
    })
    public Result getAlreadyExamination(String examinationName) {
        ArrayList<CourseApplication> data = courseExaminationService.getAlreadyExamination(examinationName);
        return new Result().success(data);
    }

    //审批一条记录
    @PostMapping("/course/examination")
    @Operation(summary = "审批一条记录", description = "对课程申请记录进行审批操作")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "审批成功"),
            @ApiResponse(responseCode = "0", description = "审批失败")
    })
    public Result examineACourse(@RequestBody CourseApplication json) {
        try {
            courseExaminationService.examineACourse(json);
            return new Result().success();
        } catch (Exception e) {
            return new Result().error(e.getMessage());
        }
    }

}
