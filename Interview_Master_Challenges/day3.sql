with rank_prank as(
select 
 prank_description,target_name,evilness_score,
row_number() over(partition by 
  target_name order by evilness_score desc,created_at desc)prank_rank
FROM
grinch_prank_ideas)
  SELECT  prank_description,target_name,evilness_score 
  from rank_prank 
  where prank_rank=1;