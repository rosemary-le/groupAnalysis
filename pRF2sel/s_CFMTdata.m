% want to store cambridge scores along with subject names
% like the behavioral data.mat but put in pRF2sel so I don't have to look
% for it
% should triple check for errors at some point

% subjects to use
behavior.controlsessions = {
    %    controls
        '42111_MN'
    '42611_AH'
    '43011_YW'
    'adult_amk_27yo_042910'
      'adult_al_22yo_051108'
    'adult_cmb_23yo_070608'
    'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
    'adult_kll_18yo_052408'
    'adult_kw_fmri2_27yo_092910'
    'adult_mem_18yo_062608'
    %         'adult_jc_27yo_052408'
    'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    '42811_TA'};

behavior.controlRawScore = ...
 [ 71 59 51 48 66 50 69 53 68 70 nan 68 nan nan nan nan];
 %mn  ah yw amk al cb dy jw kl kw mem rb acg ca TM   TA
 
behavior.controlPC = ...
 [.99 .82 .69 .67 .92 .71 .96 .74 .94 .97 nan .94 nan nan nan nan];
 %mn  ah   yw amk al  cb  dy   jw  kl kw  mem rb  acg ca  TM   TA  
 
 behavior.controlPC1 = ...
 [1   1    1   1   1  1   1    1   1   1 nan  1 nan nan nan nan];
 %mn  ah   yw amk al  cb  dy   jw  kl kw  mem rb  acg ca  TM   TA 
 
  behavior.controlPC2 = ...
 [1   .83  .6  .6  .93  .7  .93 .63  1 1   nan  .97 nan nan nan nan];
 %mn  ah   yw amk  al  cb  dy   jw  kl kw  mem rb  acg ca  TM   TA  
 
   behavior.controlPC3 = ...
 [.96  .67 .58 .5  .83  .5 .96  .67 .83 .92  nan  .88 nan nan nan nan];
 %mn  ah   yw amk  al  cb  dy   jw  kl  kw   mem  rb  acg ca  TM   TA  

 behavior.controlRT = ...
[ 3208   5992    3862    3774    3651     4601   3472  3156   2141 2352 nan 3208 nan nan nan nan];
 %mn      ah      yw      amk     al      cb      dy   jw     kl   kw   mem rb acg ca TM TA
 
 behavior.controlRT1 = ...
[ 2601.50 1996.06 2387.39 1996.33 2086.72 1457.61 1489.22  2587.56  1905.83 1921.39 nan 1943.39 nan nan nan nan];
 %mn      ah      yw      amk     al      cb      dy      jw        kl      kw      mem rb acg ca TM TA

  behavior.controlRT2 = ...
[ 3298.43 6638.43 4571.93 4666.30 4071.57 5090.93 4211.27 3600.27  2106.10 2367.50 nan 3100.80 nan nan nan nan];
 %mn      ah      yw      amk     al      cb      dy      jw        kl     %kw     mem rb      acg ca TM TA
 
   behavior.controlRT3 = ...
[ 3548.88 8182.33 4081.75 3990.63 4298.25 6347.13 4036.13 3028.17  2360.75 2654.50 nan 4291.58 nan nan nan nan];
 %mn      ah      yw      amk     al      cb      dy      jw        kl     %%kw     mem rb      acg ca TM TA
 
behavior.prososessions = {
    %     prosos
    '112909whFMRI'
    '082509_nj_proso'
    '020209_mr_fmri'
    '0100609jm'
    '102909mb'
    '11109km_proso'
    '52309AF'
    };

behavior.prosoRawScore = ...
    [31 39 46 45 38 37 28];
    %wh nj mr jm mb km af
 
behavior.prosoPC = ...
   [.43 .54 .64 .63 .53 .51 .39];
    %wh  nj  mr  jm mb  km   af

behavior.prosoPC1 = ...
   [.78 .61  1   .94 .89 .94 .56];
    %wh  nj  mr  jm  mb  km   af
    
behavior.prosoPC2 = ...
   [.33 .50  .53 .53 .43 .37 .43];
    %wh  nj  mr  jm  mb  km   af
    
behavior.prosoPC3 = ...
   [.29 .54  .50 .50 .38 .38 .21];
    %wh  nj  mr  jm  mb  km   af
    
behavior.prosoRT = ...
   [5416 6373  6637 4348 4760 3079 3770];
    %wh  nj    mr  jm    mb   km   af
    
behavior.prosoRT1 = ...
   [2835 6874  4439 4409 3648 3149 4075];
    %wh  nj    mr  jm    mb   km   af
    
behavior.prosoRT2 = ...
   [6559 6218  8762 5222 5538 3442 4724];
    %wh  nj    mr   jm    mb   km   af
    

behavior.prosoRT3 = ...
   [5924 6190  5630 3211 5630 2575 2349];
    %wh  nj    mr   jm    mb   km   af
    