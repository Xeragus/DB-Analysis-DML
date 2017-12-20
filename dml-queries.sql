-- 1.

select vacation.id, content.price
from vacation join content
	on vacation.id = content.vacationid
where vacation.country like 'M%a%ija'

-- 2.

select hotel
from transport join package
	on transport.id = package.id
group by hotel
having count(distinct transport.transport) > 3

-- 3.

with vacationcity as
(select vacationid, count(distinct city)
from content join package
	on content.packageid=package.id
group by vacationid)

select vacation.*
from vacation join vacationcity 
	on vacation.id = vacationcity.vacationid
where vacationcity.count > 2

-- 4.1

-- if there are more than 1 vacations with the same maximum, then the solution will not give us the correct results

with vacationtransport as
(select vacid, count(distinct transport) transport_count
from content c join transport t
	on c.packageid=t.packageid
group by vacid)

select top 1 v.*
from vacation v join vacationtransport vt
	on v.id = vt.id
order by transport_count desc

-- in that case we can use this solution

with vacationtrasport as
(select c.vacid, count(distinct transport) transport_count
from content c join transport t
	on c.packageid=t.packageid
group by c.vacid)

select v.*
from vacation v join vacationtransport vt
	on v.vacid=vt.vacid
where vt.transport_count = (select max(transport_count)
				from vacationtransport)

-- third solution

select vacid, count(distinct transport) transport_count
into £vacationtransport
from content c join transport t 
	on c.packageid=t.packageid
group by vacid

select max(transport_count) maks
into #maxtransport 
from #vacationtransport

with targetvacation as
(select vacid
from #vacationtransport vt join #maxtransport mt
	on vt.transportno = mt.maks)

select v.*
from vacation v join targetvacation tv
	on v.vacid=tv.vacid



























