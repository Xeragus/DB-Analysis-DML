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




























