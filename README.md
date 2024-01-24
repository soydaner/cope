# co-test

Except for this file, everything is the same as it was at the start of our session  
As I mentioned, I believe I can more effectively architect Scenario 2, having designed many solutions before.   
It is not an excuse, but for the first task, I failed in my git push attempt and a typo ('weather' instead of 'wheather') took an extra ten minutes.  
Therefore, I couldn't find enough time for a proper design, and decided on a quicker IaaS-based solution  
However, I can assure you that I have designed EKS, ECS, and AKS solutions in the past  

# next time for scenario 1 
- add lint in github actions
- github autoneticate on AWS (role, etc)
- check terraform best practices (official and google)
- proper tagging (cost center etc)
- terraform: s3 bucket and dynamodb, lock table, statefile, etc
- create a pipeline (AWS documents, etc. accept user input for terraform steps)
- code deploy: better: MR auto triggered, fully automated, CI/CD 
- github role should be in gen env.
- python version to image tag and ecr immutable
