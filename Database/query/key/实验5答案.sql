--���S_T���ݿ�
--1.	��ʾ����Ժϵ�����ڽ����������һ���ֶΡ�Ժϵ��ģ������������Ժϵ����>=5����ֶ�ֵΪ����ģ�ܴ󡱣�����Ժϵ�������ڵ���4С��5����ֶ�ֵΪ����ģһ�㡱�� ����Ժϵ�������ڵ���2С��4����ֶ�ֵΪ����ģ��С����������ʾ����ģ��С����
select sdept,Ժϵ��ģ=case 
                      when count(*)>=5 then '��ģ�ܴ�'
					  when count(*)>=4 and count(*)<5 then '��ģһ��'
					  when count(*)>=2 and count(*)<4 then '��ģ��С'
					  else '��ģ��С'
					  end
from student
group by sdept
--2.	��ʾѧ����Ϣ���е�ѧ����������ƽ�����䣬�ڽ�������б���ֱ�ָ��Ϊ��ѧ����������ƽ�����䡱��
select ѧ��������=count(*),ƽ������=avg(sage)
from student
--3.	��ʾѡ�޵Ŀγ�������3�ĸ���ѧ����ѡ�޿γ�����
select sno ,ѡ�޿γ���=count(cno)
from sc
group by sno
having count(cno)>=3
--4.	���γ̺Ž�����ʾѡ�޸����γ̵�����������߳ɼ�����ͳɼ���ƽ���ɼ���
select cno ,ѡ��������=count(*),��߳ɼ�=max(grade),��ͳɼ�=min(grade),ƽ���ɼ�=avg(grade)
from sc
group by cno
order by cno desc
--5.	�г��ж������Ͽγ̣������ţ��������ѧ����ѧ�ż�������������
select sno,����������=count(*)
from sc
where grade<60
group by sno
having count(*)>=2
--���company���ݿ�
--1����Ա����employee��ͳ��Ա��������
select COUNT(*) ���� from employee
--2��ͳ�Ƹ�����Ա����Ա��������ƽ��нˮ��
select dept,COUNT(*) ����,AVG(salary) ƽ������
from employee
group by dept
--3����ѯ����ҵ������10000Ԫ��Ա����š�
select sale_id
from sales
group by sale_id
having SUM(tot_amt)>10000
--4������ÿһ��Ʒ���������ܺ���ƽ�����۵��ۡ�
select prod_id,SUM(qty) ���������ܺ�,SUM(qty*unit_price)/SUM(qty) ƽ�����۵���
from sale_item
group by prod_id
--5��ͳ�Ƹ����Ų�ͬ�Ա𡢻�����š���ͬ�Ա������Ա����ƽ��нˮ������GROUP  BY �Ӿ���ʹ��CUBE�ؼ��֣�
select dept,sex,AVG(salary)
from employee
group by dept,sex with cube
--6��ͳ�Ƹ����Ų�ͬ�Ա𡢻�����Ż�����Ա����ƽ��нˮ������GROUP  BY �Ӿ���ʹ��ROLLUP�ؼ��֣�
select dept,sex,AVG(salary)
from employee
group by dept,sex with rollup
--7�������һ�������˼��ֲ�Ʒ��
select  COUNT(distinct prod_id)
from sale_item
--8����ʾsale_item����ÿ�ֲ�Ʒ�Ķ�������ܺͣ������������۽���ɴ�С��������ʾ��ÿһ�ֲ�Ʒ�����а�
select prod_id,SUM(qty*unit_price) ��������ܺ�
from sale_item
group by prod_id
order by ��������ܺ�  desc
--9������ÿһ��Ʒÿ�µ����۽���ܺͣ�������������ۣ��·ݣ���Ʒ��ţ�����
select prod_id,MONTH(order_date) �·�,sum(qty*unit_price) ���۽���ܺ�
from sale_item
group by prod_id,MONTH(order_date)
order by �·�,prod_id
--10����ѯÿλҵ��Ա�����µ�ҵ��������ҵ��Ա��š��·ݽ�������
select sale_id,MONTH(order_date) �·�,SUM(tot_amt) ����ҵ��
from sales
group by sale_id,MONTH(order_date)
order by sale_id desc,MONTH(order_date) desc