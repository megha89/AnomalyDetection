function plot_data(part1,part2,part3,temp,energy) %data col 1 is temp and col 2 energy, col3 is the predicted energy

    figure;
    scatter(part1(:,1),part1(:,2),'b');
    hold on;
    scatter(part2(:,1),part2(:,2),'b');
    hold on;
    scatter(part3(:,1),part3(:,2),'b')
    hold on;
    plot(part1(:,1),part1(:,3),'k');
    hold on;
    plot(part2(:,1),part2(:,3),'k');
    hold on;
    plot(part3(:,1),part3(:,3),'k')
    hold on;
    plot(temp,energy,'r*')
    hold off;
    xlabel('Temperature bins')
    ylabel('Average Energy ')
    title('Anomalies marked on Training data (90%)')
    legend('Actual data','','','Predicted values','','','Anomalies')
    
    
end
