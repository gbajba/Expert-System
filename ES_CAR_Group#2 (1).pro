domains
risks=symbol
causes=symbol
question=symbol
facts
yes_answer(causes)
no_answer(causes)
predicates
nondeterm start
nondeterm repeat 
nondeterm slo
nondeterm test
nondeterm risks(symbol)
nondeterm causes(symbol)
nondeterm res_yes
nondeterm res_no
check(question,causes)
savedata(causes,symbol)
ask(question,causes)
clauses
start:-
write(" Welcome to the Project Risk Identification System\n\n"),
write("Please answer the following test questions with yes or no (y/n), to know the type of risk."),repeat.
%loop to can repeat the test (retest)
repeat:-
nl,nl,test, % call test
write("\n\nDo you want to retest? (y/n) "),
readchar(Ans), write(Ans),Ans><'n',!,
nl,res_yes,res_no,repeat.
repeat:-
write("\n\nThank you for using our system...\n\n").
slo:-
write("\nDo you want to show solution ? (y:for soultion / n:for exit) "),
readchar(Ans), write(Ans),Ans><'n',!,
write("\nImplement risk management to avoid risks before it happens. \nplan the risk management activity, determine risks are likely to affect, numerically estimating the affects of risks,\nplan the risk response, and monitoring and controlling risks.").
% main start testing
test:-
risks(Risks),!,
write("\nThe test have been finished.. \n"),
write("There is a possibility that you have ",Risks),slo.
test:- % if it is ambiguous answers
write("\nWe could not identify the risk type").
% check for pre-answer about causes 
check(_,Causes):-
yes_answer(Causes),!.
%check for pre-answer if it's in the same risk,and ask user
check(Question,Causes):-
not(no_answer(Causes)),ask(Question,Causes).
% ask user and read the answer
ask(Question,Causes):-
write(Question), readln(Answer),
savedata(Causes,Answer),Answer="y".
% remember pre-answers of causes
savedata(Causes,"y"):-
asserta(yes_answer(Causes)). %remember yes answers
savedata(Causes,"n"):-
asserta(no_answer(Causes)). %remember no answers
%clear all the saved answers from system to restart
res_yes:-retract(yes_answer(_)),fail.
res_yes.
res_no:-retract(no_answer(_)),fail.
res_no.
%causes
% causes of Budget Risk
causes(budget_estimated):- check("Is the budget has not been estimated properly (y/n)",budget_estimated).
causes(project_expanded):- check("Are the project has expanded unexpectedly (y/n)",project_expanded).
causes(costs_overrun):- check("Are the Costs have overrun (y/n)",costs_overrun).
%causes of Operational Risk
causes(priority_conflicts):- check("Are the Priority conflicts not resolved properly (y/n)",priority_conflicts).
causes(responsibilities):- check("Are the Responsibilities have not been resolved properly (y/n)",responsibilities).
causes(lack_resources):- check("Is there a Lack of resources. (y/n)",lack_resources).
causes(lack_training):- check("Is there a Lack of training (y/n)",lack_training).
causes(lack_planning):- check("Is there a Lack of planning and scheduling for the resources(y/n)",lack_planning).
causes(lack_comm):- check("Is there a Lack of communication in the team (y/n)",lack_comm).
%causes of Technical Risk
causes(project_requirements):- check("Are The project requirements are changing continuously (y/n)",project_requirements).
causes(technology_advancement):- check("Are Technology advancement is not available (y/n)",technology_advancement).
causes(project_impl):- check("Are the Project implementation is complex (y/n)",project_impl).
causes(integr_modules):- check("Are the Integration of modules has become difficult (y/n)",integr_modules).
%causes of Programmatic Risk
causes(lack_funds):- check("Are there a Lack of funds (y/n)",lack_funds).
causes(market_dev):- check("Are there No market development (y/n)",market_dev).
causes(product_strategy):- check("Are the Product strategy is changed (y/n)",product_strategy).
%causes of Schedule Risk
causes(time_estimat):- check("Are The time for delivery is estimated wrongly (y/n)",time_estimat).
causes(tracking):- check("Are Tracking for the resources is not done properly (y/n)",tracking).
causes(complex_func):- check("Are The complex functionalities not identified properly (y/n)",complex_func).
causes(project_expanded):- check("Are The project has been expanded unexpectedly (y/n)",project_expanded).
%risks
risks(budget_risk):-causes(budget_estimated),causes(project_expanded),causes(costs_overrun).
risks(operational_risk):-causes(priority_conflicts),causes(responsibilities),causes(lack_resources),causes(lack_training),causes(lack_planning),causes(lack_comm).
risks(technical_risk):-causes(project_requirements),causes(technology_advancement),causes(project_impl),causes(integr_modules).
risks(programmatic_risk):-causes(lack_funds),causes(market_dev),causes(product_strategy).
risks(schedule_risk):-causes(time_estimat),causes(tracking),causes(complex_func),causes(project_expanded).
goal
start.