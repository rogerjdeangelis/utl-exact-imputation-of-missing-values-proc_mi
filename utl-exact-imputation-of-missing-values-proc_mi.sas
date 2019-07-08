Exact imputation of missing values                                                                                                   
                                                                                                                                     
Using regression covariates to exactly extimate missing depenedt variables values.                                                   
                                                                                                                                     
You wil get this warning becuse of just one imputation so there is not covariance matrix.                                            
Thus there is not variability in the imputation                                                                                      
                                                                                                                                     
WARNING: The posterior covariance matrix is singular.                                                                                
Imputed values for some variables may be fixed.                                                                                      
                                                                                                                                     
https://tinyurl.com/y5gzthpb                                                                                                         
https://github.com/rogerjdeangelis/utl-exact-imputation-of-missing-values-proc_mi                                                    
                                                                                                                                     
https://tinyurl.com/yypdo26z                                                                                                         
https://communities.sas.com/t5/Statistical-Procedures/How-do-I-impute-missing-values-for-a-single-variable-using-PROC/m-p/571727     
                                                                                                                                     
KurtBremser Profile                                                                                                                  
https://communities.sas.com/t5/user/viewprofilepage/user-id/11562                                                                    
                                                                                                                                     
                                                                                                                                     
*_                   _                                                                                                               
(_)_ __  _ __  _   _| |_                                                                                                             
| | '_ \| '_ \| | | | __|                                                                                                            
| | | | | |_) | |_| | |_                                                                                                             
|_|_| |_| .__/ \__,_|\__|                                                                                                            
        |_|                                                                                                                          
;                                                                                                                                    
                                                                                                                                     
data have;                                                                                                                           
  retain x1 x2 raw_y;                                                                                                                
  do x1=1 to 4;                                                                                                                      
   do x2=1 to 4;                                                                                                                     
     y=2*x1 + x2;                                                                                                                    
     perfect_y=y;                                                                                                                    
     if mod(y,3)=0 then y=.;                                                                                                         
     raw_y=y;                                                                                                                        
     output;                                                                                                                         
   end;                                                                                                                              
  end;                                                                                                                               
                                                                                                                                     
run;quit;                                                                                                                            
                                                                                                                                     
                                                                                                                                     
                                      | RULES we want imputation to                                                                  
WO%RK.HAVE total obs=16               |  discover and use the equation below                                                         
                                      |                                                                                              
                            PERFECT_  |  IMPUTED_                                                                                    
 RAW_Y    X1    X2     Y        Y     |      Y                                                                                       
                                      |           Y=2*x1 + x2                                                                        
    .      1     1     .        3     |      3                                                                                       
    4      1     2     4        4     |      4                                                                                       
    5      1     3     5        5     |      5                                                                                       
    .      1     4     .        6     |      6                                                                                       
    5      2     1     5        5     |      5                                                                                       
    .      2     2     .        6     |      6                                                                                       
    7      2     3     7        7     |      7  Y=2*2 + 3 = 7                                                                        
    8      2     4     8        8     |      8                                                                                       
    7      3     1     7        7     |      7                                                                                       
    8      3     2     8        8     |      8                                                                                       
    .      3     3     .        9     |      9                                                                                       
   10      3     4    10       10     |     10                                                                                       
    .      4     1     .        9     |      9                                                                                       
   10      4     2    10       10     |     10                                                                                       
   11      4     3    11       11     |     11                                                                                       
    .      4     4     .       12     |     12   Y=2*4 + 4 = 12                                                                      
                                                                                                                                     
                                                                                                                                     
 *            _               _                                                                                                      
  ___  _   _| |_ _ __  _   _| |_                                                                                                     
 / _ \| | | | __| '_ \| | | | __|                                                                                                    
| (_) | |_| | |_| |_) | |_| | |_                                                                                                     
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                    
                |_|                                                                                                                  
;                                                                                                                                    
                                                                                                                                     
WORK,WANT total obs=16                                                                                                               
                                                                                                                                     
                                                                                                                                     
   X1    X2  RAW_Y     PERFECT_Y    IMPUTED_Y                                                                                        
                                                                                                                                     
    1     1     .          3             3                                                                                           
    1     2     4          4             4                                                                                           
    1     3     5          5             5                                                                                           
    1     4     .          6             6                                                                                           
    2     1     5          5             5                                                                                           
    2     2     .          6             6                                                                                           
    2     3     7          7             7                                                                                           
    2     4     8          8             8                                                                                           
    3     1     7          7             7                                                                                           
    3     2     8          8             8                                                                                           
    3     3     .          9             9                                                                                           
    3     4    10         10            10                                                                                           
    4     1     .          9             9                                                                                           
    4     2    10         10            10                                                                                           
    4     3    11         11            11                                                                                           
    4     4     .         12            12                                                                                           
                                                                                                                                     
                                                                                                                                     
*          _       _   _                                                                                                             
 ___  ___ | |_   _| |_(_) ___  _ __                                                                                                  
/ __|/ _ \| | | | | __| |/ _ \| '_ \                                                                                                 
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                                                
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                                                
                                                                                                                                     
;                                                                                                                                    
                                                                                                                                     
proc mi data=have nimpute=1 out=want(rename=y=imputed_y);                                                                            
  var x1 x2 y;                                                                                                                       
run;quit;                                                                                                                            
                                                                                                                                     
                                                                                                                                     
