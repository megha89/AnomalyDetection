%%This file is Copyright (C) 2018 Megha Gaur.

function plot_data_part2(part1,part2,temp,energy) %data col 1 is temp and col 2 energy, col3 is the predicted energy
    
    figure;
    s1 = scatter(part1(:,1),part1(:,2),'b');
    hold on;
    scatter(part2(:,1),part2(:,2),'b');
    hold on;
    p1 = plot(part1(:,1),part1(:,3),'k');
    hold on;
    plot(part2(:,1),part2(:,3),'k');
    hold on;
    p4 = plot(temp,energy,'r*');
    hold off;
    xlabel('Temperature bins (Celsius)','FontSize',15)
    ylabel('Average Energy (KWh)','FontSize',15)
    %title('Anomalies marked on Training data ')
    %legend('Actual data','','','Predicted values','','','Anomalies')
    legend([s1,p1,p4],{'NORMAL DATA','REGRESSION MODEL','ANOMALIES'},'FontSize', 15)
    
end