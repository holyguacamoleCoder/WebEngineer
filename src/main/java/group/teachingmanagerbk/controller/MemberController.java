package group.teachingmanagerbk.controller;

import group.teachingmanagerbk.dto.member.QueryStudentParam;
import group.teachingmanagerbk.dto.member.QueryTeacherParam;
import group.teachingmanagerbk.service.MemberService;
import group.teachingmanagerbk.utils.ReturnResult.Result;
import group.teachingmanagerbk.utils.ReturnResult.ResultWithTotal;
import group.teachingmanagerbk.vo.member.Student;
import group.teachingmanagerbk.vo.member.Teacher;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@Slf4j
@RestController
@Tag(name = "学校信息管理接口")
public class MemberController {

    @Autowired
    MemberService memberService;

    //获取学院的信息
    @GetMapping("/departments")
    @Operation(summary = "获取学院信息", description = "获取所有学院的信息")
    @ApiResponse(responseCode = "1", description = "成功获取学院信息")
    public Result getDepartmentsInfo() {
        return new Result().success(memberService.getDepartmentInfo());
    }

    //获取教师信息
    @PostMapping("/teachers")
    @Operation(summary = "获取教师信息", description = "根据查询参数获取教师的详细信息")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "成功获取教师信息"),
            @ApiResponse(responseCode = "0", description = "查询条件无效")
    })
    public Result getTeachersInfo(@RequestBody QueryTeacherParam json) {
        log.info(json.toString());
        ResultWithTotal teachersInfo = memberService.getTeachersInfo(json);
        return teachersInfo.success();
    }

    //获取所有教师信息
    @GetMapping("/get/teachers")
    @Operation(summary = "获取所有教师信息", description = "获取所有教师的详细信息")
    @ApiResponse(responseCode = "1", description = "成功获取教师列表")
    public Result getTeachers() {
        ArrayList<Teacher> teachers = memberService.getTeachers();
        return new Result().success(teachers);
    }

    //新增教师信息
    @PostMapping("/teacher")
    @Operation(summary = "新增教师信息", description = "新增一名教师的基本信息")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "教师信息新增成功"),
            @ApiResponse(responseCode = "0", description = "教师信息新增失败")
    })
    public Result addTeacherInfo(@RequestBody Teacher json) {
        if (memberService.insertTeacher(json)) {
            return new Result().success();
        }
        return new Result().error("插入数据失败！");
    }

    //根据id删除教师信息
    @DeleteMapping("/teachers/{teacherIds}")
    @Operation(summary = "删除教师信息", description = "根据教师ID删除教师的相关信息")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "删除教师信息成功"),
            @ApiResponse(responseCode = "0", description = "删除教师信息失败")
    })
    public Result deleteTeachersInfo(@PathVariable String[] teacherIds) {
        log.info("根据id{}删除教师的信息", (Object) teacherIds);
        memberService.deleteTeacher(teacherIds);
        return new Result().success();
    }

    //根据教师id查询对应的教师信息
    @GetMapping("/get/teacher")
    @Operation(summary = "根据教师ID查询信息", description = "根据教师ID获取对应教师的详细信息")
    @ApiResponse(responseCode = "1", description = "成功获取教师信息")
    public Result getTeacherInfoById(@RequestParam String teacherId) {
        Teacher info = memberService.getTeacherInfoById(teacherId);
        return new Result().success(info);
    }

    //根据教师id修改教师信息
    @PutMapping("/modify/teacher")
    @Operation(summary = "修改教师信息", description = "根据教师ID修改教师的基本信息")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "教师信息更新成功"),
            @ApiResponse(responseCode = "0", description = "教师信息更新失败")
    })
    public Result modifyStudentInfo(@RequestBody Teacher teacher) {
        log.info(teacher.toString());
        if (memberService.updateTeacherInfoById(teacher)) {
            return new Result().success();
        };
        return new Result().error("更新信息失败！");
    }

    //获取学生信息
    @PostMapping("/students")
    @Operation(summary = "获取学生信息", description = "根据查询参数获取学生的详细信息")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "成功获取学生信息"),
            @ApiResponse(responseCode = "0", description = "查询条件无效")
    })
    public Result getStudentsInfo(@RequestBody QueryStudentParam json) {
        log.info(json.toString());
        ResultWithTotal studentsInfo = memberService.getStudentsInfo(json);
        return studentsInfo.success();
    }

    //新增学生信息
    @PostMapping("/student")
    @Operation(summary = "新增学生信息", description = "新增一名学生的基本信息")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "学生信息新增成功"),
            @ApiResponse(responseCode = "0", description = "学生信息新增失败")
    })
    public Result addStudentInfo(@RequestBody Student json) {
        if (memberService.insertStudent(json)) {
            return new Result().success();
        }
        return new Result().error("插入数据失败！");
    }

    //根据id删除学生信息
    @DeleteMapping("/students/{studentIds}")
    @Operation(summary = "删除学生信息", description = "根据学生ID删除学生的相关信息")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "删除学生信息成功"),
            @ApiResponse(responseCode = "0", description = "删除学生信息失败")
    })
    public Result deleteStudentsInfo(@PathVariable String[] studentIds) {
        log.info("根据id{}删除学生的信息", (Object) studentIds);
        memberService.deleteStudent(studentIds);
        return new Result().success();
    }

    //根据学生id查询对应的学生信息
    @GetMapping("/get/student")
    @Operation(summary = "根据学生ID查询信息", description = "根据学生ID获取对应学生的详细信息")
    @ApiResponse(responseCode = "1", description = "成功获取学生信息")
    public Result getStudentInfoById(@RequestParam String studentId) {
        Student info = memberService.getStudentInfoById(studentId);
        return new Result().success(info);
    }

    //根据学生id修改学生信息
    @PutMapping("/modify/student")
    @Operation(summary = "修改学生信息", description = "根据学生ID修改学生的基本信息")
    @ApiResponses({
            @ApiResponse(responseCode = "1", description = "学生信息更新成功"),
            @ApiResponse(responseCode = "0", description = "学生信息更新失败")
    })
    public Result modifyStudentInfo(@RequestBody Student student) {
        log.info(student.toString());
        if (memberService.updateStudentInfoById(student)) {
            return new Result().success();
        };
        return new Result().error("更新信息失败！");
    }

}
