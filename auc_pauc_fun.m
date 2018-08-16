%%This file is Copyright (C) 2018 Megha Gaur.

function [auc_weekday, auc_weekend, pauc_weekday,pauc_weekend] = auc_pauc_fun(roc_weekday1,roc_weekday2,roc_weekday3,roc_weekday4,roc_weekday5,roc_weekday6,roc_weekday7,roc_weekday8,roc_weekday9,roc_weekday10,roc_weekday11,roc_weekend1,roc_weekend2,roc_weekend3,roc_weekend4,roc_weekend5,roc_weekend6,roc_weekend7,roc_weekend8,roc_weekend9,roc_weekend10,roc_weekend11)
%function [auc_weekday, auc_weekend, pauc_weekday,pauc_weekend] = auc_pauc_fun(roc_weekday1,roc_weekday2,roc_weekday3,roc_weekday4,roc_weekday5,roc_weekday6,roc_weekday7,roc_weekday8,roc_weekday9,roc_weekend1,roc_weekend2,roc_weekend3,roc_weekend4,roc_weekend5,roc_weekend6,roc_weekend7,roc_weekend8,roc_weekend9)


%FPR and TPR on weekdays for 3 different threshold values
fpr_weekday1 = roc_weekday1.fpr;
tpr_weekday1 = roc_weekday1.tpr;
fpr_weekday2 = roc_weekday2.fpr;
tpr_weekday2 = roc_weekday2.tpr;
fpr_weekday3 = roc_weekday3.fpr;
tpr_weekday3 = roc_weekday3.tpr;
fpr_weekday4 = roc_weekday4.fpr;
tpr_weekday4 = roc_weekday4.tpr;
fpr_weekday5 = roc_weekday5.fpr;
tpr_weekday5 = roc_weekday5.tpr;
fpr_weekday6 = roc_weekday6.fpr;
tpr_weekday6 = roc_weekday6.tpr;
fpr_weekday7 = roc_weekday7.fpr;
tpr_weekday7 = roc_weekday7.tpr;
fpr_weekday8 = roc_weekday8.fpr;
tpr_weekday8 = roc_weekday8.tpr;
fpr_weekday9 = roc_weekday9.fpr;
tpr_weekday9 = roc_weekday9.tpr;
fpr_weekday10 = roc_weekday10.fpr;
tpr_weekday10 = roc_weekday10.tpr;
fpr_weekday11 = roc_weekday11.fpr;
tpr_weekday11 = roc_weekday11.tpr;

%FPR and TPR on weekends for 3 different threshold values
fpr_weekend1 = roc_weekend1.fpr;
tpr_weekend1 = roc_weekend1.tpr;
fpr_weekend2 = roc_weekend2.fpr;
tpr_weekend2 = roc_weekend2.tpr;
 fpr_weekend3 = roc_weekend3.fpr;
 tpr_weekend3 = roc_weekend3.tpr;
fpr_weekend4 = roc_weekend4.fpr;
tpr_weekend4 = roc_weekend4.tpr;
fpr_weekend5 = roc_weekend5.fpr;
tpr_weekend5 = roc_weekend5.tpr;
fpr_weekend6 = roc_weekend6.fpr;
tpr_weekend6 = roc_weekend6.tpr;
fpr_weekend7 = roc_weekend7.fpr;
tpr_weekend7 = roc_weekend7.tpr;
fpr_weekend8 = roc_weekend8.fpr;
tpr_weekend8 = roc_weekend8.tpr;
fpr_weekend9 = roc_weekend9.fpr;
tpr_weekend9 = roc_weekend9.tpr;
fpr_weekend10 = roc_weekend10.fpr;
tpr_weekend10 = roc_weekend10.tpr;
fpr_weekend11 = roc_weekend11.fpr;
tpr_weekend11 = roc_weekend11.tpr;

fpr_weekday = [fpr_weekday1 fpr_weekday2 fpr_weekday3 fpr_weekday4 fpr_weekday5 fpr_weekday6 fpr_weekday7 fpr_weekday8 fpr_weekday9 fpr_weekday10 fpr_weekday11];
tpr_weekday = [tpr_weekday1 tpr_weekday2 tpr_weekday3 tpr_weekday4 tpr_weekday5 tpr_weekday6 tpr_weekday7 tpr_weekday8 tpr_weekday9 tpr_weekday10 tpr_weekday11];
fpr_weekend = [fpr_weekend1 fpr_weekend2 fpr_weekend3 fpr_weekend4 fpr_weekend5 fpr_weekend6 fpr_weekend7 fpr_weekend8 fpr_weekend9 fpr_weekend10 fpr_weekend11];
tpr_weekend = [tpr_weekend1 tpr_weekend2 tpr_weekend3 tpr_weekend4 tpr_weekend5 tpr_weekend6 tpr_weekend7 tpr_weekend8 tpr_weekend9 tpr_weekend10 tpr_weekend11];

[sort_fpr_weekday, idx1] = sort(fpr_weekday);
sort_tpr_weekday = tpr_weekday(idx1);
[sort_fpr_weekend, idx2] = sort(fpr_weekend);
sort_tpr_weekend = tpr_weekend(idx2);
figure;
plot(sort_fpr_weekday,sort_tpr_weekday);
xlabel('FPR');
ylabel('TPR');
%hold on;
figure;
plot(sort_fpr_weekend,sort_tpr_weekend);
xlabel('FPR');
ylabel('TPR');
%legend('weekdays','weekends')
%hold off;

auc_weekday = trapz(sort_fpr_weekday,sort_tpr_weekday); 
auc_weekend = trapz(sort_fpr_weekend,sort_tpr_weekend); 

%For pauc, range of fpr  is taken to be less than 10%
fpr_weekday_pauc = [fpr_weekday1 fpr_weekday2 fpr_weekday3];
tpr_weekday_pauc = [tpr_weekday1 tpr_weekday2 tpr_weekday3];
fpr_weekend_pauc = [fpr_weekend1 fpr_weekend2 fpr_weekend3];
tpr_weekend_pauc = [tpr_weekend1 tpr_weekend2 tpr_weekend3];
[sort_fpr_weekday_pauc, idx1] = sort(fpr_weekday_pauc);
sort_tpr_weekday_pauc = tpr_weekday_pauc(idx1);
[sort_fpr_weekend_pauc, idx2] = sort(fpr_weekend_pauc);
sort_tpr_weekend_pauc = tpr_weekend_pauc(idx2);
pauc_weekday = trapz(sort_fpr_weekday_pauc,sort_tpr_weekday_pauc); 
pauc_weekend = trapz(sort_fpr_weekend_pauc,sort_tpr_weekend_pauc); 

end


