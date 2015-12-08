%=======================================================================
% MAT-fem 1.0  - MAT-fem is a learning tool for undestanding 
%                the Finite Element Method with MATLAB and GiD
%=======================================================================
% PROBLEM TITLE = Titulo del problema
%
%  Material Properties
%
  young =   210000000000.00000 ;
  poiss =              0.20000 ;
  denss = 0.00 ;
  pstrs =  1 ;
  thick =  1 ;
%
% Coordinates
%
global coordinates
coordinates = [
         0.00000   ,         0.00000  ;
         0.00000   ,         0.30000  ;
         0.50000   ,         0.00000  ;
         0.50000   ,         0.30000  ;
         0.00000   ,         0.60000  ;
         0.50000   ,         0.60000  ;
         0.00000   ,         0.90000  ;
         1.00000   ,         0.00000  ;
         0.50000   ,         0.90000  ;
         1.00000   ,         0.30000  ;
         1.00000   ,         0.60000  ;
         0.00000   ,         1.20000  ;
         0.50000   ,         1.20000  ;
         1.00000   ,         0.90000  ;
         0.00000   ,         1.50000  ;
         1.50000   ,         0.00000  ;
         1.50000   ,         0.30000  ;
         1.00000   ,         1.20000  ;
         0.50000   ,         1.50000  ;
         1.50000   ,         0.60000  ;
         1.50000   ,         0.90000  ;
         0.00000   ,         1.80000  ;
         1.00000   ,         1.50000  ;
         0.50000   ,         1.80000  ;
         1.50000   ,         1.20000  ;
         2.00000   ,         0.00000  ;
         2.00000   ,         0.30000  ;
         1.00000   ,         1.80000  ;
         2.00000   ,         0.60000  ;
         0.00000   ,         2.10000  ;
         1.50000   ,         1.50000  ;
         0.50000   ,         2.10000  ;
         2.00000   ,         0.90000  ;
         1.00000   ,         2.10000  ;
         2.00000   ,         1.20000  ;
         1.50000   ,         1.80000  ;
         0.00000   ,         2.40000  ;
         0.50000   ,         2.40000  ;
         2.50000   ,         0.00000  ;
         2.00000   ,         1.50000  ;
         2.50000   ,         0.30000  ;
         2.50000   ,         0.60000  ;
         1.50000   ,         2.10000  ;
         1.00000   ,         2.40000  ;
         2.50000   ,         0.90000  ;
         2.00000   ,         1.80000  ;
         0.00000   ,         2.70000  ;
         0.50000   ,         2.70000  ;
         2.50000   ,         1.20000  ;
         1.50000   ,         2.40000  ;
         1.00000   ,         2.70000  ;
         2.00000   ,         2.10000  ;
         2.50000   ,         1.50000  ;
         0.00000   ,         3.00000  ;
         3.00000   ,         0.00000  ;
         3.00000   ,         0.30000  ;
         0.50000   ,         3.00000  ;
         3.00000   ,         0.60000  ;
         2.50000   ,         1.80000  ;
         1.50000   ,         2.70000  ;
         2.00000   ,         2.40000  ;
         3.00000   ,         0.90000  ;
         1.00000   ,         3.00000  ;
         3.00000   ,         1.20000  ;
         2.50000   ,         2.10000  ;
         1.50000   ,         3.00000  ;
         3.00000   ,         1.50000  ;
         2.00000   ,         2.70000  ;
         2.50000   ,         2.40000  ;
         3.00000   ,         1.80000  ;
         3.50000   ,         0.00000  ;
         3.50000   ,         0.30000  ;
         3.50000   ,         0.60000  ;
         2.00000   ,         3.00000  ;
         3.50000   ,         0.90000  ;
         3.00000   ,         2.10000  ;
         2.50000   ,         2.70000  ;
         3.50000   ,         1.20000  ;
         3.50000   ,         1.50000  ;
         3.00000   ,         2.40000  ;
         2.50000   ,         3.00000  ;
         3.50000   ,         1.80000  ;
         4.00000   ,         0.00000  ;
         4.00000   ,         0.30000  ;
         3.00000   ,         2.70000  ;
         4.00000   ,         0.60000  ;
         3.50000   ,         2.10000  ;
         4.00000   ,         0.90000  ;
         4.00000   ,         1.20000  ;
         3.00000   ,         3.00000  ;
         3.50000   ,         2.40000  ;
         4.00000   ,         1.50000  ;
         4.00000   ,         1.80000  ;
         3.50000   ,         2.70000  ;
         4.50000   ,         0.00000  ;
         4.50000   ,         0.30000  ;
         4.00000   ,         2.10000  ;
         4.50000   ,         0.60000  ;
         4.50000   ,         0.90000  ;
         3.50000   ,         3.00000  ;
         4.50000   ,         1.20000  ;
         4.00000   ,         2.40000  ;
         4.50000   ,         1.50000  ;
         4.00000   ,         2.70000  ;
         4.50000   ,         1.80000  ;
         4.50000   ,         2.10000  ;
         4.00000   ,         3.00000  ;
         5.00000   ,         0.00000  ;
         5.00000   ,         0.30000  ;
         5.00000   ,         0.60000  ;
         5.00000   ,         0.90000  ;
         4.50000   ,         2.40000  ;
         5.00000   ,         1.20000  ;
         5.00000   ,         1.50000  ;
         4.50000   ,         2.70000  ;
         5.00000   ,         1.80000  ;
         4.50000   ,         3.00000  ;
         5.00000   ,         2.10000  ;
         5.50000   ,         0.00000  ;
         5.50000   ,         0.30000  ;
         5.50000   ,         0.60000  ;
         5.00000   ,         2.40000  ;
         5.50000   ,         0.90000  ;
         5.50000   ,         1.20000  ;
         5.00000   ,         2.70000  ;
         5.50000   ,         1.50000  ;
         5.50000   ,         1.80000  ;
         5.00000   ,         3.00000  ;
         5.50000   ,         2.10000  ;
         6.00000   ,         0.00000  ;
         5.50000   ,         2.40000  ;
         6.00000   ,         0.30000  ;
         6.00000   ,         0.60000  ;
         6.00000   ,         0.90000  ;
         6.00000   ,         1.20000  ;
         5.50000   ,         2.70000  ;
         6.00000   ,         1.50000  ;
         6.00000   ,         1.80000  ;
         5.50000   ,         3.00000  ;
         6.00000   ,         2.10000  ;
         6.00000   ,         2.40000  ;
         6.50000   ,         0.00000  ;
         6.50000   ,         0.30000  ;
         6.50000   ,         0.60000  ;
         6.50000   ,         0.90000  ;
         6.00000   ,         2.70000  ;
         6.50000   ,         1.20000  ;
         6.50000   ,         1.50000  ;
         6.00000   ,         3.00000  ;
         6.50000   ,         1.80000  ;
         6.50000   ,         2.10000  ;
         6.50000   ,         2.40000  ;
         7.00000   ,         0.00000  ;
         7.00000   ,         0.30000  ;
         7.00000   ,         0.60000  ;
         6.50000   ,         2.70000  ;
         7.00000   ,         0.90000  ;
         7.00000   ,         1.20000  ;
         6.50000   ,         3.00000  ;
         7.00000   ,         1.50000  ;
         7.00000   ,         1.80000  ;
         7.00000   ,         2.10000  ;
         7.00000   ,         2.40000  ;
         7.50000   ,         0.00000  ;
         7.00000   ,         2.70000  ;
         7.50000   ,         0.30000  ;
         7.50000   ,         0.60000  ;
         7.50000   ,         0.90000  ;
         7.50000   ,         1.20000  ;
         7.00000   ,         3.00000  ;
         7.50000   ,         1.50000  ;
         7.50000   ,         1.80000  ;
         7.50000   ,         2.10000  ;
         7.50000   ,         2.40000  ;
         7.50000   ,         2.70000  ;
         8.00000   ,         0.00000  ;
         8.00000   ,         0.30000  ;
         8.00000   ,         0.60000  ;
         8.00000   ,         0.90000  ;
         7.50000   ,         3.00000  ;
         8.00000   ,         1.20000  ;
         8.00000   ,         1.50000  ;
         8.00000   ,         1.80000  ;
         8.00000   ,         2.10000  ;
         8.00000   ,         2.40000  ;
         8.00000   ,         2.70000  ;
         8.50000   ,         0.00000  ;
         8.50000   ,         0.30000  ;
         8.50000   ,         0.60000  ;
         8.00000   ,         3.00000  ;
         8.50000   ,         0.90000  ;
         8.50000   ,         1.20000  ;
         8.50000   ,         1.50000  ;
         8.50000   ,         1.80000  ;
         8.50000   ,         2.10000  ;
         8.50000   ,         2.40000  ;
         8.50000   ,         2.70000  ;
         9.00000   ,         0.00000  ;
         9.00000   ,         0.30000  ;
         8.50000   ,         3.00000  ;
         9.00000   ,         0.60000  ;
         9.00000   ,         0.90000  ;
         9.00000   ,         1.20000  ;
         9.00000   ,         1.50000  ;
         9.00000   ,         1.80000  ;
         9.00000   ,         2.10000  ;
         9.00000   ,         2.40000  ;
         9.00000   ,         2.70000  ;
         9.00000   ,         3.00000  ;
         9.50000   ,         0.00000  ;
         9.50000   ,         0.30000  ;
         9.50000   ,         0.60000  ;
         9.50000   ,         0.90000  ;
         9.50000   ,         1.20000  ;
         9.50000   ,         1.50000  ;
         9.50000   ,         1.80000  ;
         9.50000   ,         2.10000  ;
         9.50000   ,         2.40000  ;
         9.50000   ,         2.70000  ;
         9.50000   ,         3.00000  ;
        10.00000   ,         0.00000  ;
        10.00000   ,         0.30000  ;
        10.00000   ,         0.60000  ;
        10.00000   ,         0.90000  ;
        10.00000   ,         1.20000  ;
        10.00000   ,         1.50000  ;
        10.00000   ,         1.80000  ;
        10.00000   ,         2.10000  ;
        10.00000   ,         2.40000  ;
        10.00000   ,         2.70000  ;
        10.00000   ,         3.00000  ] ; 
%
% Elements
%
global elements
elements = [
    220   ,    219   ,    230   ,    231   ; 
    209   ,    208   ,    219   ,    220   ; 
    200   ,    197   ,    208   ,    209   ; 
    190   ,    186   ,    197   ,    200   ; 
    180   ,    175   ,    186   ,    190   ; 
    170   ,    165   ,    175   ,    180   ; 
    159   ,    156   ,    165   ,    170   ; 
    149   ,    146   ,    156   ,    159   ; 
    139   ,    136   ,    146   ,    149   ; 
    128   ,    125   ,    136   ,    139   ; 
    117   ,    115   ,    125   ,    128   ; 
    107   ,    104   ,    115   ,    117   ; 
    100   ,     94   ,    104   ,    107   ; 
     90   ,     85   ,     94   ,    100   ; 
     81   ,     77   ,     85   ,     90   ; 
     74   ,     68   ,     77   ,     81   ; 
     66   ,     60   ,     68   ,     74   ; 
     63   ,     51   ,     60   ,     66   ; 
     57   ,     48   ,     51   ,     63   ; 
     54   ,     47   ,     48   ,     57   ; 
    219   ,    218   ,    229   ,    230   ; 
    208   ,    207   ,    218   ,    219   ; 
    197   ,    196   ,    207   ,    208   ; 
    186   ,    185   ,    196   ,    197   ; 
    175   ,    174   ,    185   ,    186   ; 
    165   ,    163   ,    174   ,    175   ; 
    156   ,    152   ,    163   ,    165   ; 
    146   ,    141   ,    152   ,    156   ; 
    136   ,    131   ,    141   ,    146   ; 
    125   ,    122   ,    131   ,    136   ; 
    115   ,    112   ,    122   ,    125   ; 
    104   ,    102   ,    112   ,    115   ; 
     94   ,     91   ,    102   ,    104   ; 
     85   ,     80   ,     91   ,     94   ; 
     77   ,     69   ,     80   ,     85   ; 
     68   ,     61   ,     69   ,     77   ; 
     60   ,     50   ,     61   ,     68   ; 
     51   ,     44   ,     50   ,     60   ; 
     48   ,     38   ,     44   ,     51   ; 
     47   ,     37   ,     38   ,     48   ; 
    218   ,    217   ,    228   ,    229   ; 
    207   ,    206   ,    217   ,    218   ; 
    196   ,    195   ,    206   ,    207   ; 
    185   ,    184   ,    195   ,    196   ; 
    174   ,    173   ,    184   ,    185   ; 
    163   ,    162   ,    173   ,    174   ; 
    152   ,    151   ,    162   ,    163   ; 
    141   ,    140   ,    151   ,    152   ; 
    131   ,    129   ,    140   ,    141   ; 
    122   ,    118   ,    129   ,    131   ; 
    112   ,    106   ,    118   ,    122   ; 
    102   ,     97   ,    106   ,    112   ; 
     91   ,     87   ,     97   ,    102   ; 
     80   ,     76   ,     87   ,     91   ; 
     69   ,     65   ,     76   ,     80   ; 
     61   ,     52   ,     65   ,     69   ; 
     50   ,     43   ,     52   ,     61   ; 
     44   ,     34   ,     43   ,     50   ; 
     38   ,     32   ,     34   ,     44   ; 
     37   ,     30   ,     32   ,     38   ; 
    217   ,    216   ,    227   ,    228   ; 
    206   ,    205   ,    216   ,    217   ; 
    195   ,    194   ,    205   ,    206   ; 
    184   ,    183   ,    194   ,    195   ; 
    173   ,    172   ,    183   ,    184   ; 
    162   ,    161   ,    172   ,    173   ; 
    151   ,    150   ,    161   ,    162   ; 
    140   ,    138   ,    150   ,    151   ; 
    129   ,    127   ,    138   ,    140   ; 
    118   ,    116   ,    127   ,    129   ; 
    106   ,    105   ,    116   ,    118   ; 
     97   ,     93   ,    105   ,    106   ; 
     87   ,     82   ,     93   ,     97   ; 
     76   ,     70   ,     82   ,     87   ; 
     65   ,     59   ,     70   ,     76   ; 
     52   ,     46   ,     59   ,     65   ; 
     43   ,     36   ,     46   ,     52   ; 
     34   ,     28   ,     36   ,     43   ; 
     32   ,     24   ,     28   ,     34   ; 
     30   ,     22   ,     24   ,     32   ; 
    216   ,    215   ,    226   ,    227   ; 
    205   ,    204   ,    215   ,    216   ; 
    194   ,    193   ,    204   ,    205   ; 
    183   ,    182   ,    193   ,    194   ; 
    172   ,    171   ,    182   ,    183   ; 
    161   ,    160   ,    171   ,    172   ; 
    150   ,    148   ,    160   ,    161   ; 
    138   ,    137   ,    148   ,    150   ; 
    127   ,    126   ,    137   ,    138   ; 
    116   ,    114   ,    126   ,    127   ; 
    105   ,    103   ,    114   ,    116   ; 
     93   ,     92   ,    103   ,    105   ; 
     82   ,     79   ,     92   ,     93   ; 
     70   ,     67   ,     79   ,     82   ; 
     59   ,     53   ,     67   ,     70   ; 
     46   ,     40   ,     53   ,     59   ; 
     36   ,     31   ,     40   ,     46   ; 
     28   ,     23   ,     31   ,     36   ; 
     24   ,     19   ,     23   ,     28   ; 
     22   ,     15   ,     19   ,     24   ; 
      3   ,      4   ,      2   ,      1   ; 
      8   ,     10   ,      4   ,      3   ; 
     16   ,     17   ,     10   ,      8   ; 
     26   ,     27   ,     17   ,     16   ; 
     39   ,     41   ,     27   ,     26   ; 
     55   ,     56   ,     41   ,     39   ; 
     71   ,     72   ,     56   ,     55   ; 
     83   ,     84   ,     72   ,     71   ; 
     95   ,     96   ,     84   ,     83   ; 
    108   ,    109   ,     96   ,     95   ; 
    119   ,    120   ,    109   ,    108   ; 
    130   ,    132   ,    120   ,    119   ; 
    142   ,    143   ,    132   ,    130   ; 
    153   ,    154   ,    143   ,    142   ; 
    164   ,    166   ,    154   ,    153   ; 
    176   ,    177   ,    166   ,    164   ; 
    187   ,    188   ,    177   ,    176   ; 
    198   ,    199   ,    188   ,    187   ; 
    210   ,    211   ,    199   ,    198   ; 
    221   ,    222   ,    211   ,    210   ; 
      4   ,      6   ,      5   ,      2   ; 
     10   ,     11   ,      6   ,      4   ; 
     17   ,     20   ,     11   ,     10   ; 
     27   ,     29   ,     20   ,     17   ; 
     41   ,     42   ,     29   ,     27   ; 
     56   ,     58   ,     42   ,     41   ; 
     72   ,     73   ,     58   ,     56   ; 
     84   ,     86   ,     73   ,     72   ; 
     96   ,     98   ,     86   ,     84   ; 
    109   ,    110   ,     98   ,     96   ; 
    120   ,    121   ,    110   ,    109   ; 
    132   ,    133   ,    121   ,    120   ; 
    143   ,    144   ,    133   ,    132   ; 
    154   ,    155   ,    144   ,    143   ; 
    166   ,    167   ,    155   ,    154   ; 
    177   ,    178   ,    167   ,    166   ; 
    188   ,    189   ,    178   ,    177   ; 
    199   ,    201   ,    189   ,    188   ; 
    211   ,    212   ,    201   ,    199   ; 
    222   ,    223   ,    212   ,    211   ; 
      6   ,      9   ,      7   ,      5   ; 
     11   ,     14   ,      9   ,      6   ; 
     20   ,     21   ,     14   ,     11   ; 
     29   ,     33   ,     21   ,     20   ; 
     42   ,     45   ,     33   ,     29   ; 
     58   ,     62   ,     45   ,     42   ; 
     73   ,     75   ,     62   ,     58   ; 
     86   ,     88   ,     75   ,     73   ; 
     98   ,     99   ,     88   ,     86   ; 
    110   ,    111   ,     99   ,     98   ; 
    121   ,    123   ,    111   ,    110   ; 
    133   ,    134   ,    123   ,    121   ; 
    144   ,    145   ,    134   ,    133   ; 
    155   ,    157   ,    145   ,    144   ; 
    167   ,    168   ,    157   ,    155   ; 
    178   ,    179   ,    168   ,    167   ; 
    189   ,    191   ,    179   ,    178   ; 
    201   ,    202   ,    191   ,    189   ; 
    212   ,    213   ,    202   ,    201   ; 
    223   ,    224   ,    213   ,    212   ; 
      9   ,     13   ,     12   ,      7   ; 
     14   ,     18   ,     13   ,      9   ; 
     21   ,     25   ,     18   ,     14   ; 
     33   ,     35   ,     25   ,     21   ; 
     45   ,     49   ,     35   ,     33   ; 
     62   ,     64   ,     49   ,     45   ; 
     75   ,     78   ,     64   ,     62   ; 
     88   ,     89   ,     78   ,     75   ; 
     99   ,    101   ,     89   ,     88   ; 
    111   ,    113   ,    101   ,     99   ; 
    123   ,    124   ,    113   ,    111   ; 
    134   ,    135   ,    124   ,    123   ; 
    145   ,    147   ,    135   ,    134   ; 
    157   ,    158   ,    147   ,    145   ; 
    168   ,    169   ,    158   ,    157   ; 
    179   ,    181   ,    169   ,    168   ; 
    191   ,    192   ,    181   ,    179   ; 
    202   ,    203   ,    192   ,    191   ; 
    213   ,    214   ,    203   ,    202   ; 
    224   ,    225   ,    214   ,    213   ; 
     13   ,     19   ,     15   ,     12   ; 
     18   ,     23   ,     19   ,     13   ; 
     25   ,     31   ,     23   ,     18   ; 
     35   ,     40   ,     31   ,     25   ; 
     49   ,     53   ,     40   ,     35   ; 
     64   ,     67   ,     53   ,     49   ; 
     78   ,     79   ,     67   ,     64   ; 
     89   ,     92   ,     79   ,     78   ; 
    101   ,    103   ,     92   ,     89   ; 
    113   ,    114   ,    103   ,    101   ; 
    124   ,    126   ,    114   ,    113   ; 
    135   ,    137   ,    126   ,    124   ; 
    147   ,    148   ,    137   ,    135   ; 
    158   ,    160   ,    148   ,    147   ; 
    169   ,    171   ,    160   ,    158   ; 
    181   ,    182   ,    171   ,    169   ; 
    192   ,    193   ,    182   ,    181   ; 
    203   ,    204   ,    193   ,    192   ; 
    214   ,    215   ,    204   ,    203   ; 
    225   ,    226   ,    215   ,    214   ] ; 
%
% Fixed Nodes
%
fixnodes = [
      1  , 1 ,    0.00000  ;
      1  , 2 ,    0.00000  ;
      2  , 1 ,    0.00000  ;
      2  , 2 ,    0.00000  ;
      5  , 1 ,    0.00000  ;
      5  , 2 ,    0.00000  ;
      7  , 1 ,    0.00000  ;
      7  , 2 ,    0.00000  ;
     12  , 1 ,    0.00000  ;
     12  , 2 ,    0.00000  ;
     15  , 1 ,    0.00000  ;
     15  , 2 ,    0.00000  ;
     22  , 1 ,    0.00000  ;
     22  , 2 ,    0.00000  ;
     30  , 1 ,    0.00000  ;
     30  , 2 ,    0.00000  ;
     37  , 1 ,    0.00000  ;
     37  , 2 ,    0.00000  ;
     47  , 1 ,    0.00000  ;
     47  , 2 ,    0.00000  ;
     54  , 1 ,    0.00000  ;
     54  , 2 ,    0.00000  ] ;
%
% Point loads
%
pointload = [ ] ;
%
% Side loads
%
sideload = [
    221  ,    222  ,   30.00000  ,    0.00000  ;
    222  ,    223  ,   30.00000  ,    0.00000  ;
    223  ,    224  ,   30.00000  ,    0.00000  ;
    224  ,    225  ,   30.00000  ,    0.00000  ;
    225  ,    226  ,   30.00000  ,    0.00000  ;
    226  ,    227  ,   30.00000  ,    0.00000  ;
    227  ,    228  ,   30.00000  ,    0.00000  ;
    228  ,    229  ,   30.00000  ,    0.00000  ;
    229  ,    230  ,   30.00000  ,    0.00000  ;
    230  ,    231  ,   30.00000  ,    0.00000  ];

