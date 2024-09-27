-- 用于SQL SERVER，PostgreSQL，Oracle，MySQL(8.0)以上
-- 定义一个 CTE 用于处理去重逻辑
WITH TEST AS
(
    -- 使用 ROW_NUMBER() 给每个 SNO 和 CNO 的组合分配行号
    -- PARTITION BY SNO, CNO 将数据按照学生编号 (SNO) 和课程编号 (CNO) 分组
    -- ORDER BY SCORE 按照得分 (SCORE) 升序排序，每组得分最低的记录会获得行号 1
    SELECT ROW_NUMBER() 
    OVER(PARTITION BY SNO, CNO ORDER BY SCORE) AS NUM,
    -- 选择 SC 表中的所有列
    * 
    FROM SC
)

-- 删除所有行号不等于 1 的记录，也就是删除重复记录
-- 仅保留每个学生在同一门课程中的最低分记录
DELETE FROM TEST
WHERE NUM != 1;
