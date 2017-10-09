--���S_T���ݿ�
--1.	��ѯ��ѡ�γ̵�ƽ���ɼ�����������ƽ���ɼ���ѧ��ѧ�š�������ƽ���ɼ���
select  a.sno ,sname,avg(grade)
from student a,sc b
where a.sno=b.sno 
group by a.sno,sname
having avg(grade) > 
       (select avg(grade) 
       from student a,sc b 
	   where a.sno=b.sno and sname='����')
--2.	�г�ѡ�������ſγ̵�ѧ����ѧ�š�������Ժϵ���ɼ���
select a.sno,sname,sdept,grade
from student a,sc b
where a.sno=b.sno and a.sno in 
(select sno 
from sc 
group by sno 
having count(*)=2)
--3.	����ѡ��������һ�ź�����ѡ�޿γ�һ����ѧ����ѧ�š��������γ̺ţ�
select a.sno,sname,cno
from student a,sc b
where a.sno=b.sno and sname<>'����' and cno in 
 (select cno from student a,sc b
  where a.sno=b.sno and sname='����')
--4.��ѯ����ѡ���ˡ���Ϣϵͳ���͡���ѧ�������ſγ̵�ѧ���Ļ�����Ϣ��
select *
from student
where sno in 
(select c.sno  from course a,course b ,sc c,sc d
where a.cno=c.cno and b.cno=d.cno 
and a.cname='��Ϣϵͳ' and b.cname='��ѧ' 
and c.sno=d.sno)

--5.	��ѯֻ��һ��ѧ��ѡ�޵Ŀγ̵Ŀγ̺š��γ�����
select cno,cname
from course
where cno in (select cno from sc group by cno having count(*)=1)
--6.	������ѧ�γ̰���ѧ������������ѧ�γ̵�ѧ��ѧ�š�������
select sno,sname 
from student a
where sname<>'����' and not exists
    (select * 
	 from  student b,sc c
	 where b.sno=c.sno and sname='����' and not exists
	   (select *
	    from sc d
		where c.cno=d.cno and d.sno=a.sno) )
--7.	ʹ��Ƕ�ײ�ѯ�г�ѡ���ˡ���ѧ���γ̵�ѧ��ѧ�ź�������
select sno,sname 
from student
where sno in (select sno from course a,sc b where a.cno=b.cno and cname='��ѧ')
--8.	ʹ��Ƕ�ײ�ѯ��ѯ����ϵ������С��CSϵ��ĳ��ѧ����ѧ�������������Ժϵ��
select sname,sage,sdept
from student
where sdept<>'CS' and sage<any(select sage from student where sdept='CS')
--9.	ʹ��Ƕ�ײ�ѯ��ѯ����ϵ������С��CSϵ����ѧ�������ѧ����
select sname,sage,sdept
from student
where sdept<>'CS' and sage<all(select sage from student where sdept='CS')

--���company���ݿ�
--1��	��sales���в��ҳ����۽����ߵĶ�����
select * 
from sales 
where tot_amt=(select MAX(tot_amt)
                   from sales) 
--2��	��sales���в��ҳ����������ڡ�E0013ҵ��Ա��1996/11/10����������һ�Ŷ����Ľ������ж���������ʾ�н���Щ������ҵ��Ա�͸��������Ľ�
select *
from sales
where tot_amt>any
       (select tot_amt 
        from sales 
        where sale_id='E0013'and order_date='1996/11/10')
--3��	�ҳ���˾Ůҵ��Ա���ӵĶ�����
select *
from sales
where sale_id in(select emp_no 
                from employee 
                where sex='Ů')
--4��	�ҳ�Ŀǰҵ��δ����200000Ԫ��Ա����ź�Ա��������
select emp_no,emp_name
from employee
where emp_no in (select sale_id 
                 from sales
                 group by sale_id
                 having SUM(tot_amt)<=200000)
--5��	����������sales�в�ѯ����ҵ����ߵ�ҵ��Ա��ż�����ҵ����
select sale_id,SUM(tot_amt) 
from sales
group by sale_id
having SUM(tot_amt)=
  (select MAX(sum_amt)
   from(select sale_id,SUM(tot_amt) sum_amt
        from sales
        group by sale_id) a  )
        
 select top 1 with ties sale_id,SUM(tot_amt) sum_amt
        from sales
        group by sale_id 
        order by  sum_amt  desc  
--6��	�ҳ�Ŀǰҵ������50000Ԫ��Ա����ź�������
select emp_no,emp_name
from employee
where emp_no in (select sale_id
                 from sales
                 group by sale_id
                 having SUM(tot_amt)>50000)
--7��	��ѯ�����Ĳ�Ʒ���ٰ����˶���10003����������Ʒ�Ķ�����
select * 
from sales a
where not exists
  (select * 
   from sale_item b
   where order_no='10003' and not exists
      (select *
       from sale_item c
       where b.prod_id=c.prod_id and c.order_no=a.order_no))
--8����ѯĩ�н�ҵ���Ա������Ϣ��
select *
from employee
where emp_no not in 
  (select distinct sale_id from sales)
