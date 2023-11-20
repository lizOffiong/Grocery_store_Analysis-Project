# Grocery Store Analysis

















```sql
-- Replace 'Ã¶' with 'ö'

select CustomerName,
		case
        when CustomerName like "%Ã¶%" then replace(CustomerName, 'Ã¶', 'ö')
        else CustomerName
        end as "Clean Name"
from customers;

update customers
set CustomerName = (select
		case
        when CustomerName like "%Ã¶%" then replace(CustomerName, 'Ã¶', 'ö')
        when Customername like "%Ã­%" then replace(CustomerName, 'Ã­', 'i')
        else CustomerName
        end);
set sql_safe_updates = 0;
```
