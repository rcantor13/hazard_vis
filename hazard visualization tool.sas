*do this in SAS
*then R, then R online


*step 1 demo with constant only;

%macro constant(out, 
                mu,
                time_start = 0,
                time_stop  = 10,
                time_interval = 0.1);

    data &out;
        group = "&out";
        do t = &time_start to &time_stop by &time_interval; 
            *hazard function: lambda(t) = mu;
            lambda = &mu;
            label lambda = "lambda(t)";

            *survival function: S(t);
            S = exp(-&mu*t);
            label S = "S(t)";

            *pdf: f(t);
            pdf = &mu*exp(-&mu*t);

            *cdf: uppercase lamda(t) = mu *t;
            cdf = &mu*t;

        output;
        end;
    run;
%mend;


%constant(a, 0.4)
%constant(b, 0.2)
%constant(c, 0.1)



proc format;
    value $ group a = "mu = 0.4"
                  b = "mu = 0.2"
                  c = "mu = 0.1";
run;

data plot;
    set a b c;
    format group group.;
run;


proc sgplot data=plot;
    title "Hazard Plot";
    series x=t y=lambda / group = GROUP;
    yaxis values=(0 to 0.5 by 0.05);
run;

proc sgplot data=plot;
    title "Survival Plot";
    series x=t y=S/ group = GROUP;
    yaxis values=(0 to 1 by 0.1);
run;

proc sgplot data=plot;
    title "Cummulative Hazard Plot";
    series x=t y=cdf / group = GROUP;
    yaxis values=(0 to 4 by 0.5);
run;

proc sgplot data=plot;
    title "PDF Plot";
    series x=t y=pdf/ group = GROUP ;
    yaxis values=(0 to 0.5 by 0.05);
run;


*https://www.itl.nist.gov/div898/handbook/apr/apr.htm;
