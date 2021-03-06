select * from emp;
select e.*, d.* from emp e full join dept d on d.code = e.code;
--查询工资比人事部门所有员工工资还要高的员工的部门号，部门名称，员工号，和工资
select e2.code, d2.dept_name, e2.name, e2.sal
  from emp e2
  left join dept d2
    on e2.code = d2.code
 where e2.sal >= (select max(e.sal) from emp e where e.code = '1');
 --查询方法2   使用方法二查询的时候速度居然比方法一快了0.04秒 
 select e2.code, d2.dept_name, e2.name, e2.sal
  from emp e2
  left join dept d2
    on e2.code = d2.code
 where e2.sal >= all(select e.sal from emp e where e.code = '1');
 
/* 显示工资比人事部任意一个员工的工资高的员工的姓名，工资，部门号和部门*/
 select e2.code, d2.dept_name, e2.name, e2.sal
  from emp e2
  left join dept d2
    on e2.code = d2.code
 where e2.sal >= (select min(e.sal) from emp e where e.code = '1');
 --使用any函数查询
  select e2.code, d2.dept_name, e2.name, e2.sal
  from emp e2
  left join dept d2
    on e2.code = d2.code
 where e2.sal >= any(select e.sal from emp e where e.code = '1');

--查询与奎哥所在部门 和年龄 都相同的所有员工
select *
  from emp e1,
       (select z.code, z.year from emp z where z.name = '小奎奎') e2
 where e1.code = e2.code
   and e1.year = e2.year
   and e1.name != '小奎奎';
   
--insert into emp values('15','孙新建','sunsun','','18','20180101','11',1000000);
--commit;

--显示高于自己部门平均工资的所有员工的姓名和部门号，部门名称，以及工资

select e1.name, e1.code, e2.dept_name,e1.sal,e3.avg_sal
  from emp e1
  left join dept e2 on e1.code=e2.code, (select z.code, z2.dept_name, avg(sal) avg_sal
                        from emp z left join dept z2 on z.code=z2.code
                       group by z.code, z2.dept_name) e3
 where e1.code=e3.code and e1.sal> e3.avg_sal;
 
 select z.code, z2.dept_name, avg(sal) avg_sal
                        from emp z left join dept z2 on z.code=z2.code
                       group by z.code, z2.dept_name;

--查询emp及rownum信息：
select e.*,rownum from emp e;
select e.*,rownum rn from(select * from emp)e ;
