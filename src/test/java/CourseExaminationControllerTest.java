import group.teachingmanagerbk.controller.CourseExaminationController;
import group.teachingmanagerbk.dto.application.CourseApplication;
import group.teachingmanagerbk.service.CourseExaminationService;
import group.teachingmanagerbk.utils.ReturnResult.Result;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import java.util.ArrayList;
import java.util.Arrays;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class CourseExaminationControllerTest {

    @Mock
    private CourseExaminationService courseExaminationService;

    @InjectMocks
    private CourseExaminationController courseExaminationController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    // 创建测试用的CourseApplication对象
    private CourseApplication createTestCourseApplication() {
        CourseApplication application = new CourseApplication();
        application.setCourseApplicationId("1");
        application.setTeacherId("T001");
        application.setTeacherName("张三");
        application.setCourseId("C101");
        application.setCourseName("计算机科学导论");
        application.setCourseCredit("3");
        application.setCourseHour("48");
        application.setCourseTime("每周一 10:00-12:00");
        application.setCoursePlaceId("P001");
        application.setCoursePlaceName("逸夫楼 429");
        application.setCourseDescription("这门课程介绍计算机科学的基础概念与技术");
        application.setCourseExaminationId("1");
        application.setCourseExaminationName("待审批");
        application.setOperationId("1");
        application.setOperationName("新增");
        application.setDateTime("2025-03-29T10:00:00");
        return application;
    }

    @Test
    void testGetWaitExamination_Success() {
        // 准备测试数据
        String examinationName = "Math";
        CourseApplication app1 = createTestCourseApplication();
        CourseApplication app2 = createTestCourseApplication();
        app2.setCourseName("高等数学");

        ArrayList<CourseApplication> mockData = new ArrayList<>(Arrays.asList(app1, app2));

        // 模拟服务层行为
        when(courseExaminationService.getWaitExamination(examinationName)).thenReturn(mockData);

        // 调用控制器方法
        Result result = courseExaminationController.getWaitExamination(examinationName);

        // 验证结果
        assertEquals(1, result.getCode());
        assertEquals("success", result.getMessage());
        assertEquals(mockData, result.getData());
        verify(courseExaminationService, times(1)).getWaitExamination(examinationName);
    }

    @Test
    void testGetWaitExamination_Empty() {
        String examinationName = "Physics";
        when(courseExaminationService.getWaitExamination(examinationName)).thenReturn(new ArrayList<>());

        Result result = courseExaminationController.getWaitExamination(examinationName);

        assertEquals(1, result.getCode()); // 根据接口文档，成功但无数据返回code=1
        assertEquals("success", result.getMessage());
        assertTrue(((ArrayList<?>) result.getData()).isEmpty());
        verify(courseExaminationService, times(1)).getWaitExamination(examinationName);
    }

    @Test
    void testGetAlreadyExamination_Success() {
        String examinationName = "Chemistry";
        CourseApplication app = createTestCourseApplication();
        app.setCourseName("有机化学");
        app.setCourseExaminationName("已审批");

        ArrayList<CourseApplication> mockData = new ArrayList<>(Arrays.asList(app));

        when(courseExaminationService.getAlreadyExamination(examinationName)).thenReturn(mockData);

        Result result = courseExaminationController.getAlreadyExamination(examinationName);

        assertEquals(1, result.getCode());
        assertEquals("success", result.getMessage());
        assertEquals(mockData, result.getData());
        verify(courseExaminationService, times(1)).getAlreadyExamination(examinationName);
    }

    @Test
    void testExamineACourse_Success() throws Exception {
        CourseApplication application = createTestCourseApplication();

        doNothing().when(courseExaminationService).examineACourse(application);

        Result result = courseExaminationController.examineACourse(application);

        assertEquals(1, result.getCode());
        assertEquals("success", result.getMessage());
        assertNull(result.getData());
        verify(courseExaminationService, times(1)).examineACourse(application);
    }

    @Test
    void testExamineACourse_Failure() throws Exception {
        CourseApplication application = createTestCourseApplication();
        String errorMessage = "审批过程中发生错误";

        doThrow(new RuntimeException(errorMessage)).when(courseExaminationService).examineACourse(application);

        Result result = courseExaminationController.examineACourse(application);

        assertEquals(0, result.getCode());
        assertEquals(errorMessage, result.getMessage());
        assertNull(result.getData());
        verify(courseExaminationService, times(1)).examineACourse(application);
    }
}
