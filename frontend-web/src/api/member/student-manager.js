import request from '@/utils/request.js'

// 查询学生信息
export const getStudentsInfo = (queryStudentParam) => {
    return request.post('/students', queryStudentParam)
}

// 新增一条学生信息
export const insertStudentInfo = (form) => {
    return request.post('/student', form)
}   

//根据id删除学生信息
export const deleteStudentInfo = (studentId) => {
    return request.delete('/students/' + studentId)
}

//根据id查询学生信息
export const getStudentInfoById = (studentId) => {
    return request.get('/get/student?studentId=' + studentId)
}

//修改学生信息（后端根据id进行修改）
export const updateStudentInfoById = (form) => {
    return request.put('/modify/student', form)
}