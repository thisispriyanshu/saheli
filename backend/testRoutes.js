const data = require('./data/data.json');

const routeDetails = [
    {
        "bounds": {
            "northeast": {
                "lat": 28.8330672,
                "lng": 77.1897319
            },
            "southwest": {
                "lat": 28.5494691,
                "lng": 77.12422169999999
            }
        },
        "copyrights": "Map data ©2024",
        "legs": [
            {
                "distance": {
                    "text": "41.4 km",
                    "value": 41351
                },
                "duration": {
                    "text": "1 hour 12 mins",
                    "value": 4323
                },
                "end_address": "IIT Hostel, Deer Park, Hauz Khas, New Delhi, Delhi 110016, India",
                "end_location": {
                    "lat": 28.5498586,
                    "lng": 77.18663169999999
                },
                "start_address": "R48J+6V, Garthi Khurad, Narela, Delhi, 110040, India",
                "start_location": {
                    "lat": 28.81612119999999,
                    "lng": 77.1320716
                },
                "steps": [
                    {
                        "distance": {
                            "text": "47 m",
                            "value": 47
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 6
                        },
                        "end_location": {
                            "lat": 28.8158195,
                            "lng": 77.1323261
                        },
                        "html_instructions": "Head <b>southeast</b>",
                        "polyline": {
                            "points": "wc{nDmzwuMLc@LK^C"
                        },
                        "start_location": {
                            "lat": 28.81612119999999,
                            "lng": 77.1320716
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.2 km",
                            "value": 158
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 43
                        },
                        "end_location": {
                            "lat": 28.81625439999999,
                            "lng": 77.13384599999999
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "{a{nDa|wuMCg@MmAe@qBS[Ik@"
                        },
                        "start_location": {
                            "lat": 28.8158195,
                            "lng": 77.1323261
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "53 m",
                            "value": 53
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 21
                        },
                        "end_location": {
                            "lat": 28.8162428,
                            "lng": 77.1341635
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "qd{nDqexuMQCKICK?G@EJKJEHC"
                        },
                        "start_location": {
                            "lat": 28.81625439999999,
                            "lng": 77.13384599999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "16 m",
                            "value": 16
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 19
                        },
                        "end_location": {
                            "lat": 28.8162818,
                            "lng": 77.1343213
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "od{nDogxuMG_@"
                        },
                        "start_location": {
                            "lat": 28.8162428,
                            "lng": 77.1341635
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.4 km",
                            "value": 409
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 48
                        },
                        "end_location": {
                            "lat": 28.8128112,
                            "lng": 77.13553809999999
                        },
                        "html_instructions": "Turn <b>right</b>",
                        "maneuver": "turn-right",
                        "polyline": {
                            "points": "wd{nDohxuMdAW|HaBnDm@l@If@OTOTa@"
                        },
                        "start_location": {
                            "lat": 28.8162818,
                            "lng": 77.1343213
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.9 km",
                            "value": 1890
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 149
                        },
                        "end_location": {
                            "lat": 28.82925,
                            "lng": 77.1306255
                        },
                        "html_instructions": "Sharp <b>left</b> onto <b>NH 44</b>",
                        "maneuver": "turn-sharp-left",
                        "polyline": {
                            "points": "aoznDcpxuMk[hGe@JcB\\qFfAkB^aAP}Dt@mB\\eCh@aEz@kDr@uFhAqBb@mFjAwDv@gCh@kB\\"
                        },
                        "start_location": {
                            "lat": 28.8128112,
                            "lng": 77.13553809999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.4 km",
                            "value": 437
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 40
                        },
                        "end_location": {
                            "lat": 28.8329462,
                            "lng": 77.1293031
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "yu}nDmqwuMCPAFCBGBo@L_B^gCf@eDv@iBZgAZ[FeAX"
                        },
                        "start_location": {
                            "lat": 28.82925,
                            "lng": 77.1306255
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.5 km",
                            "value": 535
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 50
                        },
                        "end_location": {
                            "lat": 28.8288604,
                            "lng": 77.1309279
                        },
                        "html_instructions": "Make a <b>U-turn</b>",
                        "maneuver": "uturn-right",
                        "polyline": {
                            "points": "}l~nDciwuMGg@Ig@EUdAWp@MxAYVEHCvBc@x@Q~@QdBa@ZGxBe@LCLAV?T@\\D"
                        },
                        "start_location": {
                            "lat": 28.8329462,
                            "lng": 77.1293031
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "10.6 km",
                            "value": 10583
                        },
                        "duration": {
                            "text": "13 mins",
                            "value": 794
                        },
                        "end_location": {
                            "lat": 28.7384746,
                            "lng": 77.15442089999999
                        },
                        "html_instructions": "Slight <b>left</b> onto <b>NH 44</b><div style=\"font-size:0.9em\">Pass by the gas station (on the left in 3.7 km)</div>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "ks}nDiswuMNCLCPEtAYh@KrBe@fB]xCo@jCm@x@O~@OfAQv@UbDm@|Bi@zBe@b@IdB]bB_@h@OjAUj@OTGfDy@xAY^IdCa@xBe@|Ae@zBm@d@MnBe@dASdAShCi@hB_@bAUxGwA\\Kf@Oz@W^MXMf@S`@Sd@Wn@_@d@[DETMnAeALMr@q@fAuA|ByCt@cARYV]Xa@p@u@r@y@XYPSdAaAZU\\[POrAeA~AeArAq@d@Sz@Yf@O\\Kr@Qh@QVEVGVGXEn@KRCZEl@GlAKr@ClCKzBKpDW\\ClCQD?j@CtCMhCOXAFAfBIpAGr@Cn@AB?l@A^?B?b@@R?lAFn@DH@d@BLBRBVF^HLD\\HD@`@Jd@Nn@RTHVLh@T~CbBj@\\^TfBdApCxAJFXJPHv@V~@VpATpAPpAH|@BdA?x@A|@CfRiATAr@GTCl@C|@Cn@Ib@GRCh@GNCNCf@G`@EVEpAQfC_@rL}AjGy@jC]dBSfBWtFw@dAOpASJATCFA\\EtASfAQ^GrCg@fAUbASXGHAJApBa@jH_BlE_AdE_AbGsAXG~HkBtDy@zEoAfH_Bn@OlCm@nDy@`AWzJyBpCm@DAhBa@TGVGHCHAxA[~@SdHcBtA[zCs@bN}Cf@K`B_@`@KdBa@nFsAn@O`IcBvEgA@AfMsCh@MHMr@?^E"
                        },
                        "start_location": {
                            "lat": 28.8288604,
                            "lng": 77.1309279
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "2.1 km",
                            "value": 2067
                        },
                        "duration": {
                            "text": "5 mins",
                            "value": 297
                        },
                        "end_location": {
                            "lat": 28.722681,
                            "lng": 77.165216
                        },
                        "html_instructions": "Continue straight to stay on <b>NH 44</b><div style=\"font-size:0.9em\">Pass by Metro Pillar Number 131 (on the right in 1.5 km)</div>",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "m~knDcf|uMdBMf@EdAIbAKb@Ib@Kh@QTILGJGLGJGNKJUlAm@z@k@nA{@|@o@bAm@|A{@lA_A`Au@|@w@TQz@}@PMx@k@rCgBrByAvCsBfD_Cd@]hFkDt@g@~AgAxAaArB_BxCoB`BeA\\UPOl@c@n@_@lAy@jAu@VSfAs@"
                        },
                        "start_location": {
                            "lat": 28.7384746,
                            "lng": 77.15442089999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.5 km",
                            "value": 1468
                        },
                        "duration": {
                            "text": "4 mins",
                            "value": 234
                        },
                        "end_location": {
                            "lat": 28.7122242,
                            "lng": 77.1743915
                        },
                        "html_instructions": "Continue straight to stay on <b>NH 44</b><div style=\"font-size:0.9em\">Pass by Metro Pillar Number 94 (on the right in 700m)</div>",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "w{hnDsi~uMTQdBeAh@c@DE~AyAhBaB`B{AJKPM~@{@n@g@d@a@pAgAz@u@LMDCfB{A|AmAHGXWZWnC}BrBeBtAiAb@]f@]@Ax@k@xBmBjC}BLKlBeBZYrAkAb@a@"
                        },
                        "start_location": {
                            "lat": 28.722681,
                            "lng": 77.165216
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.3 km",
                            "value": 269
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 80
                        },
                        "end_location": {
                            "lat": 28.7104246,
                            "lng": 77.1761813
                        },
                        "html_instructions": "Slight <b>left</b> onto <b>AH1</b>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "kzfnD}b`vMB[BEBEnB{AdBeBBC?APQFGb@a@POHKJGZU"
                        },
                        "start_location": {
                            "lat": 28.7122242,
                            "lng": 77.1743915
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "5.4 km",
                            "value": 5404
                        },
                        "duration": {
                            "text": "9 mins",
                            "value": 534
                        },
                        "end_location": {
                            "lat": 28.6768935,
                            "lng": 77.1411508
                        },
                        "html_instructions": "Turn <b>right</b> onto <b>Mahatma Gandhi Rd</b>/<wbr/><b>Ring Rd</b><div style=\"font-size:0.9em\">Pass by Celebration Banquet By Regalia (on the left in 2.1 km)</div>",
                        "maneuver": "turn-right",
                        "polyline": {
                            "points": "cofnDcn`vM\\YRQT\\@@V\\`@f@PRNLDDFDJJbA|@xCzBBBXRRRFJJPRPTNJJVRz@n@^V^VzBbBz@n@bBtAd@^RPZV\\ZTPRPPRNPXb@@@LRJRFLHN?@L`@Rt@Nf@Nf@BLBLRr@f@dBl@rB@D\\jAL`@Lb@^pARr@BLBHBJDLDJDNLb@X~@XdAFRDRNd@`@zAJ^HZLf@H`@Lh@Jf@H`@H`@\\dBr@pDHh@@FBJBH@F@FDZ^pBn@dDPx@P`An@|Cb@pBJ`@FPHLBDPVJLXj@PT~@t@BBZPh@RnAd@jAb@\\LlAf@NF~@^~Al@nAb@bBl@XJFBn@V`Cz@lC|@\\Pb@RbBt@B@HD@?@@B@HD@?HDjAb@d@J|@PXDlFbAF@~@NdGz@tAVjARp@Lf@RXLXRVRVVPNHJVZZ\\TZNTbCjEt@jAfAbBbBrCNVX`@`@r@@?fAhBz@vAR^T`@HJHNT^LTT^@?PZT^?@T^NVNTh@`ALR\\j@r@jA`C`Er@tAfA~ART^ZRRd@Z^Tj@VVLNDNDbB`@b@H`@FfB`@h@JtATRDNDh@Lj@N"
                        },
                        "start_location": {
                            "lat": 28.7104246,
                            "lng": 77.1761813
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.9 km",
                            "value": 861
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 68
                        },
                        "end_location": {
                            "lat": 28.6696595,
                            "lng": 77.1381561
                        },
                        "html_instructions": "Keep <b>right</b> to continue on <b>Mahatma Gandhi Rd</b>/<wbr/><b>Punjabi Bagh Flyover</b>/<wbr/><b>Ring Rd</b>/<wbr/><b>Shri Hans Maharaj Setu Flyover</b>",
                        "maneuver": "keep-right",
                        "polyline": {
                            "points": "q}_nDesyuMd@Jx@Rl@JjB\\XDXFdARp@ND@\\H|A\\XHVDZJXH\\J\\HPF`@Jf@RHBHB\\LB?\\JB@VHHBXJf@Pj@PVHbBh@PDv@Zp@ZJFZP^T|@r@VR"
                        },
                        "start_location": {
                            "lat": 28.6768935,
                            "lng": 77.1411508
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.7 km",
                            "value": 709
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 141
                        },
                        "end_location": {
                            "lat": 28.6651601,
                            "lng": 77.1330061
                        },
                        "html_instructions": "Keep <b>right</b> to continue on <b>Mahatma Gandhi Rd</b>/<wbr/><b>Moti Nagar Flyover</b>/<wbr/><b>Ring Rd</b><div style=\"font-size:0.9em\">Continue to follow Mahatma Gandhi Rd/<wbr/>Ring Rd</div>",
                        "maneuver": "keep-right",
                        "polyline": {
                            "points": "kp~mDo`yuMXXRR^^|@fAZ^LNLNJJJLBDFH@@T\\|@fAPT@@@@PT?@FFPRf@l@@B@@@@RVl@t@X\\LNHLjAvApAzAz@dALPxBbC"
                        },
                        "start_location": {
                            "lat": 28.6696595,
                            "lng": 77.1381561
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.8 km",
                            "value": 839
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 141
                        },
                        "end_location": {
                            "lat": 28.6589553,
                            "lng": 77.1289978
                        },
                        "html_instructions": "Keep <b>left</b> to stay on <b>Mahatma Gandhi Rd</b>/<wbr/><b>Ring Rd</b>",
                        "maneuver": "keep-left",
                        "polyline": {
                            "points": "gt}mDi`xuMXVdBvB~AnBb@h@X\\NPRVjA`BFHt@x@LNDFHLBFBFpAhALFRJRHLDB@LDNDH?z@DL?dEHp@Dt@?^FHBP?ZBX@`@RVZ"
                        },
                        "start_location": {
                            "lat": 28.6651601,
                            "lng": 77.1330061
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "19 m",
                            "value": 19
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 5
                        },
                        "end_location": {
                            "lat": 28.6587959,
                            "lng": 77.12907659999999
                        },
                        "html_instructions": "Turn <b>left</b> toward <b>Service Rd</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "om|mDggwuM^O"
                        },
                        "start_location": {
                            "lat": 28.6589553,
                            "lng": 77.1289978
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.2 km",
                            "value": 249
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 60
                        },
                        "end_location": {
                            "lat": 28.6570429,
                            "lng": 77.1274869
                        },
                        "html_instructions": "Turn <b>right</b> onto <b>Service Rd</b>",
                        "maneuver": "turn-right",
                        "polyline": {
                            "points": "ol|mDwgwuM~EnEZPbBzA"
                        },
                        "start_location": {
                            "lat": 28.6587959,
                            "lng": 77.12907659999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "2.0 km",
                            "value": 2034
                        },
                        "duration": {
                            "text": "3 mins",
                            "value": 192
                        },
                        "end_location": {
                            "lat": 28.6405961,
                            "lng": 77.1289352
                        },
                        "html_instructions": "Keep <b>right</b> to continue on <b>Mahatma Gandhi Rd</b>/<wbr/><b>Raja Garden Flyover</b>/<wbr/><b>Ring Rd</b><div style=\"font-size:0.9em\">Continue to follow Mahatma Gandhi Rd/<wbr/>Ring Rd</div><div style=\"font-size:0.9em\">Pass by Dr Ram Bajaj (on the right in 1.3 km)</div>",
                        "maneuver": "keep-right",
                        "polyline": {
                            "points": "oa|mDy}vuMLPQXtBfBbC|BPLx@p@tAhAJHNLDDVTNLZXNLh@`@VPJHTJHDr@TTF^H`@F^DF?Z@@?r@Af@Cb@GLAVGTGl@Sh@S^MnAe@RGBAZM\\M`@OPGTK`@M`@O`@M\\MXKXIdCs@bBg@d@Mn@S\\K~@UTIdAWl@Q`Cq@|Bm@NGf@O`Bc@zAe@RIb@MpBi@d@OvDeAfBg@`@MdAYz@["
                        },
                        "start_location": {
                            "lat": 28.6570429,
                            "lng": 77.1274869
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "8.7 km",
                            "value": 8680
                        },
                        "duration": {
                            "text": "13 mins",
                            "value": 755
                        },
                        "end_location": {
                            "lat": 28.5806876,
                            "lng": 77.1749344
                        },
                        "html_instructions": "Keep <b>right</b> to continue on <b>Mahatma Gandhi Rd</b>/<wbr/><b>Mayapuri Chowk Flyover</b>/<wbr/><b>Ring Rd</b><div style=\"font-size:0.9em\">Continue to follow Mahatma Gandhi Rd</div><div style=\"font-size:0.9em\">Pass by the gas station (on the left in 7.9 km)</div>",
                        "maneuver": "keep-right",
                        "polyline": {
                            "points": "wzxmD{fwuMn@ObAYpCy@~C{@bAY`@Md@M@?JERE^IBA`@Mh@Mh@OFCVGTIBAZIlCu@TGnA]z@UtA_@XIt@SLCFAdA[h@MNELCJEJEPKpBi@HCfBa@PG^M`@MbA]`Bi@h@IjBi@z@UZK`Cq@LEVIr@QFCvA]DCB?x@UFC\\K\\IbAYFCTGBA@?DAXIFCXIHCXIRGPE`@Mv@UrA_@~@Wn@QTGBA`AYd@OFANEPEXIDA@A`@Kf@ONEHC`@Mr@UXIZKr@QNEnA_@JCJCrA_@f@K^GVCJAZA^AJ?dELL?b@@J?H?R?J?\\?R?l@AB?vAAJ?@?@AzAEzAC~@?B?^AV?`@?d@AvB?rAE`@Af@Ed@EZCd@Ib@KRGPGVK\\SfAo@~@m@lCsBtAmAv@q@JIjDwB|AeAfHoF`@Yf@_@t@s@BABC@Cp@q@r@}@l@}@P[\\k@l@sAf@sAJa@BQDQ@G`@uD@I@KBKDOBGDIHYH]F_@NsAT{Cd@oHJ{APcBDc@d@{GPeCd@eFFw@PoBb@iFJeATeCJc@N}@j@_B^u@f@{@HIj@y@lEwGZe@FIhDiFxEyGrCgEV[@Af@m@v@{@dAaAzAgAJGxBwA?AZS@??ANI|A}@LIf@[h@]HE?Ab@Yv@a@@AXQ\\Ot@e@xAcAn@]n@[RKd@WBAh@SXKb@QpAa@p@SRIJC@?b@O\\M`@QBA~@c@VYt@e@HGzCoBvG{Dd@[^UfAo@HGVMpBkAVONIPKp@]x@i@p@_@l@_@|@g@v@_@FEVM|BgARMPGVM~@c@`Ae@h@StAs@zAs@jB_A|BgAh@]JEtAm@"
                        },
                        "start_location": {
                            "lat": 28.6405961,
                            "lng": 77.1289352
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.7 km",
                            "value": 1738
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 139
                        },
                        "end_location": {
                            "lat": 28.5700017,
                            "lng": 77.1863674
                        },
                        "html_instructions": "Keep <b>right</b> to continue on <b>NH 48</b>",
                        "maneuver": "keep-right",
                        "polyline": {
                            "points": "idmmDif`vMz@_@dAi@vBaA\\QTIRK`@QHEZM~@e@FC`@QRKTK\\ObCoAp@[b@Ul@Yl@[t@c@nCuAf@Y`B{@x@c@h@WvBqAl@_@^Yp@m@bAaATSVYp@}@v@iAh@aAdAuBzBqFb@oALg@Li@Da@Dm@H_BN{CDgA@a@?GDq@"
                        },
                        "start_location": {
                            "lat": 28.5806876,
                            "lng": 77.1749344
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "81 m",
                            "value": 81
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 12
                        },
                        "end_location": {
                            "lat": 28.5699955,
                            "lng": 77.1871843
                        },
                        "html_instructions": "Slight <b>left</b> toward <b>Bikaji Cama Place Flyover</b><div style=\"font-size:0.9em\">Pass by the gas station (on the left)</div>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "oakmDymbvMCKAEAE@M?[D_B"
                        },
                        "start_location": {
                            "lat": 28.5700017,
                            "lng": 77.1863674
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.1 km",
                            "value": 148
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 30
                        },
                        "end_location": {
                            "lat": 28.5698098,
                            "lng": 77.188688
                        },
                        "html_instructions": "Continue onto <b>Bikaji Cama Place Flyover</b>",
                        "polyline": {
                            "points": "oakmD{rbvMPiCFoADm@De@"
                        },
                        "start_location": {
                            "lat": 28.5699955,
                            "lng": 77.1871843
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "93 m",
                            "value": 93
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 35
                        },
                        "end_location": {
                            "lat": 28.5696834,
                            "lng": 77.1896324
                        },
                        "html_instructions": "Continue straight",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "i`kmDi|bvMBQBg@Bc@L}A"
                        },
                        "start_location": {
                            "lat": 28.5698098,
                            "lng": 77.188688
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "2.1 km",
                            "value": 2144
                        },
                        "duration": {
                            "text": "6 mins",
                            "value": 365
                        },
                        "end_location": {
                            "lat": 28.5511765,
                            "lng": 77.1844172
                        },
                        "html_instructions": "Turn <b>right</b> onto <b>Africa Ave</b><div style=\"font-size:0.9em\">Pass by the gas station (on the right)</div>",
                        "maneuver": "turn-right",
                        "polyline": {
                            "points": "o_kmDebcvM?St@FdAFr@Dx@F`AFt@Bz@F|APpCRL@vIl@|BNfBRhDb@RDB@L@V@`@Ft@N`ATpCr@NBl@RjBf@`Cn@zCx@DBhAXLDt@RjDz@hCn@RFxBh@jBj@RDFBjBf@jBb@~@RbCf@VDXH^J^N`@LRJTJPFNJPJVPb@TRN"
                        },
                        "start_location": {
                            "lat": 28.5696834,
                            "lng": 77.1896324
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.4 km",
                            "value": 355
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 45
                        },
                        "end_location": {
                            "lat": 28.5494691,
                            "lng": 77.1867912
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "{kgmDsabvMZHJBJDp@b@\\q@DM|@{Bp@qBzAcF"
                        },
                        "start_location": {
                            "lat": 28.5511765,
                            "lng": 77.1844172
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "35 m",
                            "value": 35
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 12
                        },
                        "end_location": {
                            "lat": 28.5497595,
                            "lng": 77.186919
                        },
                        "html_instructions": "Turn <b>left</b><div style=\"font-size:0.9em\">Restricted usage road</div>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "eagmDmpbvMy@Y"
                        },
                        "start_location": {
                            "lat": 28.5494691,
                            "lng": 77.1867912
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "30 m",
                            "value": 30
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 8
                        },
                        "end_location": {
                            "lat": 28.5498586,
                            "lng": 77.18663169999999
                        },
                        "html_instructions": "Turn <b>left</b><div style=\"font-size:0.9em\">Restricted usage road</div>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "_cgmDgqbvMSx@"
                        },
                        "start_location": {
                            "lat": 28.5497595,
                            "lng": 77.186919
                        },
                        "travel_mode": "DRIVING"
                    }
                ],
                "traffic_speed_entry": [],
                "via_waypoint": []
            }
        ],
        "overview_polyline": {
            "points": "wc{nDmzwuMLc@LK^CCg@MmAe@qBS[Ik@]MCSLQTIG_@dAW|HaBnDm@tAYj@q@gg@zJyMdCiVbF_TpEkB\\CPEJ_HxAoGrAcBb@eAXGg@O}@hFeAzFkAhGsAd@Ar@FdCg@~K_CdE}@fCa@tMsCvGwAtHgBxBc@~FgAnJgC~JqBbLiC|CgA|CgBxBgBzBgCrD}EvBoCdDiD~CgCrDwB`Bm@bD_A`B[lC]jKg@bJm@dJc@tFW`CChCHlBNdEbAfC`ArI|EhEvBvBn@bDf@nCL~BAnVwApDUpBWpBWx[iEhWkDvJ}AnDs@vRcEbXgGpKiCvIoBzVyFvGyA|UqFnSuEtIuBpJsBjUkFHMr@?dCSlBOfBUpBo@t@c@JUlAm@jCgB`C}A|A{@lA_A~BmBpAoArI{FnQ}LtCoBlEaDjH{ErMsIxLwKbFgExE{DnEuDtGkF`IyGvCkCvBmBFa@rBaBhBiB|@}@bAy@p@k@V^zAfB|AtAjEfDR\\h@`@~BfBzCzB~CdCrBdBjAhAt@lA^`Ar@dC~C|K`FjQzAzGfBfJvAzHvBjKRr@LRhAfBbAx@dAd@xDvA|F|BtE`B|IbDtCpAhBr@jJfBbLdB|B`@`A`@zAnArA`BpGpKhIbNzFtJpAvBtDvGzAtBr@n@dAp@bAd@fDv@hGjAxBh@dLzBfGzAnDfAhEtAtBn@hBv@f@X|AhAdB`BtBfCxBpCjEnFbBtBtGvH~BnCbCxChChDpAzALTtApAbAb@j@L`ITpBJt@D`@RVZ^O~EnE~BlBLPQXxFdFlDrCrC`Cx@f@|@Zt@PdBN`CMhBe@lDoAjE_BrLoDvN}DxFcBrJmCpTkG|K{CbNsDfCq@v@[tFwAfFcBtCs@vAa@zEsAfFuAfCs@jOkEzH{B~C{@fDw@~AIbGNxCAbJM~BCjEEhAG`AIhAUzAo@fC}AbFaEbA{@hG}DhIiG|AsAz@{@`B{Bn@gAtAgDNs@j@yENo@`@aBd@oFp@kKnAiPbBwR`@kEZaBjAuCp@eA|GaKnPgVfDmD`FgDxCiBrEqC|EwClBaAxDsArAa@fBq@~@c@VY~@m@rLkHdAq@zEqCjBcAvEqCrIcE|GaD~GkDxLsFvEwBfG{CzGoD|HiElAy@tBoBl@m@hBgCnBwD~CaIZqAJoA`@eJDy@EQDoC~@iN?St@FxBLlFZnFd@dJn@dFb@|Dh@h@DvAVrEhAjHnBxF|A~JfC`G~AvEjAbEz@pBj@|Al@|A~@n@XVHp@b@\\q@bAiClCuIy@YSx@"
        },
        "summary": "AH1 and Mahatma Gandhi Rd",
        "warnings": [],
        "waypoint_order": []
    },
    {
        "bounds": {
            "northeast": {
                "lat": 28.8330672,
                "lng": 77.25792059999999
            },
            "southwest": {
                "lat": 28.5494691,
                "lng": 77.1293031
            }
        },
        "copyrights": "Map data ©2024",
        "legs": [
            {
                "distance": {
                    "text": "47.6 km",
                    "value": 47626
                },
                "duration": {
                    "text": "1 hour 15 mins",
                    "value": 4524
                },
                "end_address": "IIT Hostel, Deer Park, Hauz Khas, New Delhi, Delhi 110016, India",
                "end_location": {
                    "lat": 28.5498586,
                    "lng": 77.18663169999999
                },
                "start_address": "R48J+6V, Garthi Khurad, Narela, Delhi, 110040, India",
                "start_location": {
                    "lat": 28.81612119999999,
                    "lng": 77.1320716
                },
                "steps": [
                    {
                        "distance": {
                            "text": "47 m",
                            "value": 47
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 6
                        },
                        "end_location": {
                            "lat": 28.8158195,
                            "lng": 77.1323261
                        },
                        "html_instructions": "Head <b>southeast</b>",
                        "polyline": {
                            "points": "wc{nDmzwuMLc@LK^C"
                        },
                        "start_location": {
                            "lat": 28.81612119999999,
                            "lng": 77.1320716
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.2 km",
                            "value": 158
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 43
                        },
                        "end_location": {
                            "lat": 28.81625439999999,
                            "lng": 77.13384599999999
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "{a{nDa|wuMCg@MmAe@qBS[Ik@"
                        },
                        "start_location": {
                            "lat": 28.8158195,
                            "lng": 77.1323261
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "53 m",
                            "value": 53
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 21
                        },
                        "end_location": {
                            "lat": 28.8162428,
                            "lng": 77.1341635
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "qd{nDqexuMQCKICK?G@EJKJEHC"
                        },
                        "start_location": {
                            "lat": 28.81625439999999,
                            "lng": 77.13384599999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "16 m",
                            "value": 16
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 19
                        },
                        "end_location": {
                            "lat": 28.8162818,
                            "lng": 77.1343213
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "od{nDogxuMG_@"
                        },
                        "start_location": {
                            "lat": 28.8162428,
                            "lng": 77.1341635
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.4 km",
                            "value": 409
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 48
                        },
                        "end_location": {
                            "lat": 28.8128112,
                            "lng": 77.13553809999999
                        },
                        "html_instructions": "Turn <b>right</b>",
                        "maneuver": "turn-right",
                        "polyline": {
                            "points": "wd{nDohxuMdAW|HaBnDm@l@If@OTOTa@"
                        },
                        "start_location": {
                            "lat": 28.8162818,
                            "lng": 77.1343213
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.9 km",
                            "value": 1890
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 149
                        },
                        "end_location": {
                            "lat": 28.82925,
                            "lng": 77.1306255
                        },
                        "html_instructions": "Sharp <b>left</b> onto <b>NH 44</b>",
                        "maneuver": "turn-sharp-left",
                        "polyline": {
                            "points": "aoznDcpxuMk[hGe@JcB\\qFfAkB^aAP}Dt@mB\\eCh@aEz@kDr@uFhAqBb@mFjAwDv@gCh@kB\\"
                        },
                        "start_location": {
                            "lat": 28.8128112,
                            "lng": 77.13553809999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.4 km",
                            "value": 437
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 40
                        },
                        "end_location": {
                            "lat": 28.8329462,
                            "lng": 77.1293031
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "yu}nDmqwuMCPAFCBGBo@L_B^gCf@eDv@iBZgAZ[FeAX"
                        },
                        "start_location": {
                            "lat": 28.82925,
                            "lng": 77.1306255
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.5 km",
                            "value": 535
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 50
                        },
                        "end_location": {
                            "lat": 28.8288604,
                            "lng": 77.1309279
                        },
                        "html_instructions": "Make a <b>U-turn</b>",
                        "maneuver": "uturn-right",
                        "polyline": {
                            "points": "}l~nDciwuMGg@Ig@EUdAWp@MxAYVEHCvBc@x@Q~@QdBa@ZGxBe@LCLAV?T@\\D"
                        },
                        "start_location": {
                            "lat": 28.8329462,
                            "lng": 77.1293031
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "10.6 km",
                            "value": 10583
                        },
                        "duration": {
                            "text": "13 mins",
                            "value": 794
                        },
                        "end_location": {
                            "lat": 28.7384746,
                            "lng": 77.15442089999999
                        },
                        "html_instructions": "Slight <b>left</b> onto <b>NH 44</b><div style=\"font-size:0.9em\">Pass by the gas station (on the left in 3.7 km)</div>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "ks}nDiswuMNCLCPEtAYh@KrBe@fB]xCo@jCm@x@O~@OfAQv@UbDm@|Bi@zBe@b@IdB]bB_@h@OjAUj@OTGfDy@xAY^IdCa@xBe@|Ae@zBm@d@MnBe@dASdAShCi@hB_@bAUxGwA\\Kf@Oz@W^MXMf@S`@Sd@Wn@_@d@[DETMnAeALMr@q@fAuA|ByCt@cARYV]Xa@p@u@r@y@XYPSdAaAZU\\[POrAeA~AeArAq@d@Sz@Yf@O\\Kr@Qh@QVEVGVGXEn@KRCZEl@GlAKr@ClCKzBKpDW\\ClCQD?j@CtCMhCOXAFAfBIpAGr@Cn@AB?l@A^?B?b@@R?lAFn@DH@d@BLBRBVF^HLD\\HD@`@Jd@Nn@RTHVLh@T~CbBj@\\^TfBdApCxAJFXJPHv@V~@VpATpAPpAH|@BdA?x@A|@CfRiATAr@GTCl@C|@Cn@Ib@GRCh@GNCNCf@G`@EVEpAQfC_@rL}AjGy@jC]dBSfBWtFw@dAOpASJATCFA\\EtASfAQ^GrCg@fAUbASXGHAJApBa@jH_BlE_AdE_AbGsAXG~HkBtDy@zEoAfH_Bn@OlCm@nDy@`AWzJyBpCm@DAhBa@TGVGHCHAxA[~@SdHcBtA[zCs@bN}Cf@K`B_@`@KdBa@nFsAn@O`IcBvEgA@AfMsCh@MHMr@?^E"
                        },
                        "start_location": {
                            "lat": 28.8288604,
                            "lng": 77.1309279
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.9 km",
                            "value": 881
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 87
                        },
                        "end_location": {
                            "lat": 28.7378232,
                            "lng": 77.1623602
                        },
                        "html_instructions": "Exit onto <b>Dr KB Hegdewar Marg</b>/<wbr/><b>Outer Ring Rd</b>",
                        "maneuver": "ramp-left",
                        "polyline": {
                            "points": "m~knDcf|uMBIDGDEFE|@c@DEDEl@y@DIx@gBRc@Tg@Xs@r@kBPg@Ng@F[DSFWBa@@S?I@g@?_@?K?IEi@E_@C[?K?Q[u@_@kAa@{@Q_@Qg@GOIUGSIUK]Kc@Kc@EWGYI_@Ik@ASC]Cg@"
                        },
                        "start_location": {
                            "lat": 28.7384746,
                            "lng": 77.15442089999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.7 km",
                            "value": 1676
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 130
                        },
                        "end_location": {
                            "lat": 28.7336407,
                            "lng": 77.1786506
                        },
                        "html_instructions": "Keep <b>right</b> to continue on <b>Bhalswa Flyover</b>/<wbr/><b>Dr KB Hegdewar Marg</b>/<wbr/><b>Outer Ring Rd</b><div style=\"font-size:0.9em\">Continue to follow Dr KB Hegdewar Marg/<wbr/>Outer Ring Rd</div>",
                        "maneuver": "keep-right",
                        "polyline": {
                            "points": "kzknDww}uMIyBAg@@oJBsA@c@NwBDk@?CHeAFg@LcA@KFg@Hu@BQDUHe@X}A?Ah@iC`BqGT_APs@Le@jAoEn@}BLk@jBqHbDwLVs@`@yAx@uC"
                        },
                        "start_location": {
                            "lat": 28.7378232,
                            "lng": 77.1623602
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.6 km",
                            "value": 1603
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 117
                        },
                        "end_location": {
                            "lat": 28.7294969,
                            "lng": 77.19438219999999
                        },
                        "html_instructions": "Keep <b>right</b> to stay on <b>Dr KB Hegdewar Marg</b>/<wbr/><b>Outer Ring Rd</b>",
                        "maneuver": "keep-right",
                        "polyline": {
                            "points": "g`knDq}`vMLe@Rq@FWPs@XmAJe@DMDWdBkIBI@GHe@BQDSHg@Lw@DQBORmA?ADSFe@BG@KDQBSDYBMBK@K@EBM@EBSBMXkB|A{J@IHg@`@sC@KTeBL{@Fc@~A_KHk@b@qCBK~@_GFc@j@qD"
                        },
                        "start_location": {
                            "lat": 28.7336407,
                            "lng": 77.1786506
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "3.8 km",
                            "value": 3770
                        },
                        "duration": {
                            "text": "5 mins",
                            "value": 274
                        },
                        "end_location": {
                            "lat": 28.714156,
                            "lng": 77.2268299
                        },
                        "html_instructions": "Continue straight onto <b>Burari Flyover</b>/<wbr/><b>Dr KB Hegdewar Marg</b>/<wbr/><b>Outer Ring Rd</b><div style=\"font-size:0.9em\">Continue to follow Outer Ring Rd</div>",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "kfjnD{_dvMN}@ZuB~@uGHe@ZwBHg@TsAHg@Hg@DWXwBHe@T{Af@kDNs@Ny@P{@He@Jg@j@oBz@{Cn@{B~@kDdAwD@C|@aDjAoErAeF|@kDrB}HfAcEtAeFlA}Ex@yCHYNk@H]Pm@FUJa@FSVkAd@sBd@qB\\_BFSVeA@E`BsGRs@d@cBDQ`BkFFOXo@nAcCHOPa@Pc@Tg@Tg@p@qAv@qAR]PWb@q@?A@A\\c@TQ@APMROn@WlC{@tC{@nBMp@Ml@Kb@Id@GD?JAZAl@CL?"
                        },
                        "start_location": {
                            "lat": 28.7294969,
                            "lng": 77.19438219999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "3.8 km",
                            "value": 3768
                        },
                        "duration": {
                            "text": "7 mins",
                            "value": 397
                        },
                        "end_location": {
                            "lat": 28.6806435,
                            "lng": 77.2293376
                        },
                        "html_instructions": "Keep <b>right</b> to continue on <b>Outer Ring Rd</b>/<wbr/><b>Wazirabad Flyover</b><div style=\"font-size:0.9em\">Continue to follow Outer Ring Rd</div><div style=\"font-size:0.9em\">Pass by Indraprastha Gas Limited CNG Station (on the left in 3.6 km)</div>",
                        "maneuver": "keep-right",
                        "polyline": {
                            "points": "ofgnDujjvMdBHh@D~@Ht@Fh@Df@@j@@^AZCRAZEt@OTGZKXKj@Qx@Ud@MD?XCHA|@EbAGRAXCNA@?f@GTE`AQh@MdAUXIRENCTEPCTCXEXCF?b@Cb@Cj@Af@?T@N?N@P?\\Bv@Dd@DpALbCPJ@dAHb@DR@v@@n@AjBKVAX@rADtD@fADd@BrDN|DJnFRvABRCJ?pF_AlAOLANALAx@ClA?pECbIM~@AbACX?\\Cp@G`@Gj@If@MVGj@QvAc@rC}@TGVGr@KPCt@Gd@E`AEf@Ab@AZA|CItEKdDK|CIlCEVAfACfEI"
                        },
                        "start_location": {
                            "lat": 28.714156,
                            "lng": 77.2268299
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.2 km",
                            "value": 214
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 28
                        },
                        "end_location": {
                            "lat": 28.6787932,
                            "lng": 77.2295824
                        },
                        "html_instructions": "Slight <b>left</b>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "_u`nDkzjvMh@SLCJELATClAKr@Id@MVCHAHBHBJF^L"
                        },
                        "start_location": {
                            "lat": 28.6806435,
                            "lng": 77.2293376
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "17 m",
                            "value": 17
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 2
                        },
                        "end_location": {
                            "lat": 28.6786462,
                            "lng": 77.2296094
                        },
                        "html_instructions": "Slight <b>left</b> onto <b>NH 44</b>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "mi`nD{{jvMZE"
                        },
                        "start_location": {
                            "lat": 28.6787932,
                            "lng": 77.2295824
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.4 km",
                            "value": 1433
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 143
                        },
                        "end_location": {
                            "lat": 28.6670075,
                            "lng": 77.2339891
                        },
                        "html_instructions": "Continue straight to stay on <b>NH 44</b><div style=\"font-size:0.9em\">Pass by Ladakh Budh Vihar (on the left in 700m)</div>",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "qh`nDa|jvMTARCLCZI`@Ml@]f@c@PQp@aAd@Ut@i@d@Y`@MTE^DjBZFB`AZ`AN~@NXBJ@B@D?N?L?@?LANC@AbDo@jCg@PEnB[z@Q~AWhCw@b@Ob@MPG`@OlAc@`Be@bAQn@SXKNIPMRQ@AzDmF"
                        },
                        "start_location": {
                            "lat": 28.6786462,
                            "lng": 77.2296094
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "3.6 km",
                            "value": 3565
                        },
                        "duration": {
                            "text": "5 mins",
                            "value": 303
                        },
                        "end_location": {
                            "lat": 28.645238,
                            "lng": 77.2556925
                        },
                        "html_instructions": "Slight <b>left</b> to stay on <b>NH 44</b><div style=\"font-size:0.9em\">Pass by the water (on the left in 2.2 km)</div>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "y_~mDmwkvM\\_A^qAR_@LOLMPITKl@Mx@K`AGpBMfACVCPEPERITMNOBGNQnAsB@AjAwCZcAPi@Zw@~A}D@E@G?E?MAe@As@@gAAU?OESCOOm@e@qAQo@CY@[Jk@H_@@WAm@NiHBKDOBKFOJS`@[BC`Ai@nAg@f@W@Ap@g@V]^i@Xe@nA}B@ETg@Tc@j@cAz@yAfAkBR]LQHKJKRQRQPIPIVIZGPCD?ZClBCfAAFAXC\\Cb@G`@I\\KbAYBAj@SFCxAe@PGhAg@h@Yl@a@fDmBHEt@a@|A{@zCaBb@W@?HGBAHE@??ADC@?JG@??AJEzAw@|Ay@zAw@jFuCfB}@pAw@zEoCpAw@r@g@VU`@_@`AaA"
                        },
                        "start_location": {
                            "lat": 28.6670075,
                            "lng": 77.2339891
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "2.4 km",
                            "value": 2376
                        },
                        "duration": {
                            "text": "3 mins",
                            "value": 176
                        },
                        "end_location": {
                            "lat": 28.6325122,
                            "lng": 77.2470921
                        },
                        "html_instructions": "Continue straight to stay on <b>NH 44</b>",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "wwymDa_pvMVYXWb@_@l@a@l@_@\\STMZOb@StBw@j@Uv@WVK|@]lAa@j@QVG`@I`@GXC`@A`@?X@Z?b@D`@Fb@Hb@HxCp@^Jv@PdBd@`@JB@z@ThAXfFpAr@Nr@PXHXLTNTTJJ?@LTLZFT@HBL@N@LA^ATANCPCRCTAHG\\Id@?@Kh@Kj@Ih@ADOdAEb@?DE`@AXAR?R?t@?zB?hB?tEA|@?vD?`C?jA@TFTDHDHDHFFLHJDPDJBH@v@A|@@hB?jABrAD^BZ@"
                        },
                        "start_location": {
                            "lat": 28.645238,
                            "lng": 77.2556925
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.8 km",
                            "value": 1777
                        },
                        "duration": {
                            "text": "3 mins",
                            "value": 160
                        },
                        "end_location": {
                            "lat": 28.6168956,
                            "lng": 77.2497894
                        },
                        "html_instructions": "Slight <b>right</b> to stay on <b>NH 44</b>",
                        "maneuver": "turn-slight-right",
                        "polyline": {
                            "points": "ehwmDiinvMd@NbANTBVBbAAdACP?P?b@A`@?bB@D?h@?n@ApCCh@?j@AT?b@?H?L?n@A\\?T?RAt@?l@?fA?jAAd@?ZCVAZCXCXGj@Gn@KhBc@f@MpBc@FArDw@zCq@DA`@IvAc@LCh@OVGZGREv@QlAUDA~@Q|Bk@fCk@dB]f@ItBm@"
                        },
                        "start_location": {
                            "lat": 28.6325122,
                            "lng": 77.2470921
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.3 km",
                            "value": 295
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 38
                        },
                        "end_location": {
                            "lat": 28.6166936,
                            "lng": 77.2502631
                        },
                        "html_instructions": "Take the exit toward <b>Pragati Maidan Tunnel</b><div style=\"font-size:0.9em\">Closed 12:00 – 6:00 AM</div>",
                        "maneuver": "ramp-left",
                        "polyline": {
                            "points": "sftmDeznvMTUHId@QPKPEPENENIFIDIBM@K@MAKAOCKCIGIGIGEOII?Q?Q@IBA?A?A@KHIFCFABENCLA??J@J@RHTBF"
                        },
                        "start_location": {
                            "lat": 28.6168956,
                            "lng": 77.2497894
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.4 km",
                            "value": 1370
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 127
                        },
                        "end_location": {
                            "lat": 28.615676,
                            "lng": 77.2378908
                        },
                        "html_instructions": "Continue onto <b>Pragati Maidan Tunnel</b><div style=\"font-size:0.9em\">Closed 12:00 – 6:00 AM</div>",
                        "polyline": {
                            "points": "ietmDc}nvMd@d@NPh@j@FHB@d@h@b@n@FHv@vAFNh@hAR^P^^jBF`ADVHvBBPBPDZ@\\@VAp@CNCNELEJIRo@tAMVEHsAxDERw@zBKXCHCDKXKXQf@CH?@o@~AADABKVA@ADABKX]jAERAP?B?F?JBVBN@LBLBRLn@DHPd@Nd@b@fAbB|EPd@"
                        },
                        "start_location": {
                            "lat": 28.6166936,
                            "lng": 77.2502631
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.4 km",
                            "value": 385
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 43
                        },
                        "end_location": {
                            "lat": 28.6139027,
                            "lng": 77.2346324
                        },
                        "html_instructions": "Merge onto <b>Purana Quila Rd</b>",
                        "maneuver": "merge",
                        "polyline": {
                            "points": "__tmDyolvMt@tBDPZ`AbAzCb@jAf@fBHZHPHHDFNLPHRH`@N"
                        },
                        "start_location": {
                            "lat": 28.615676,
                            "lng": 77.2378908
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.7 km",
                            "value": 654
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 70
                        },
                        "end_location": {
                            "lat": 28.6095511,
                            "lng": 77.23140939999999
                        },
                        "html_instructions": "Slight <b>left</b> onto <b>C - Hexagon</b>/<wbr/><b>India Gate Cir</b>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "{ssmDm{kvM~EJR@D?X?vCJz@BVDNFTFRHLFPNNPNJNf@`@nAPf@^dANb@Nf@t@fBp@tB"
                        },
                        "start_location": {
                            "lat": 28.6139027,
                            "lng": 77.2346324
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.2 km",
                            "value": 203
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 27
                        },
                        "end_location": {
                            "lat": 28.6101001,
                            "lng": 77.22953919999999
                        },
                        "html_instructions": "Slight <b>right</b> to stay on <b>C - Hexagon</b>/<wbr/><b>India Gate Cir</b><div style=\"font-size:0.9em\">Pass by Bikaner House (on the left)</div>",
                        "maneuver": "turn-slight-right",
                        "polyline": {
                            "points": "uxrmDigkvMJp@@P@H?J?NANCNCNCNENCFAFITWl@aAfB"
                        },
                        "start_location": {
                            "lat": 28.6095511,
                            "lng": 77.23140939999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.9 km",
                            "value": 866
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 92
                        },
                        "end_location": {
                            "lat": 28.603805,
                            "lng": 77.22445189999999
                        },
                        "html_instructions": "Turn <b>left</b> onto <b>Shahjahan Rd</b><div style=\"font-size:0.9em\">Pass by Union Public Service Commission (on the right in 350m)</div>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "c|rmDs{jvMBTDLDLFNHRBFnB~Ax@f@x@h@rDbC~ClB|AhAl@`@BB|CvBPL@?pDfCf@ZRN^X|@r@"
                        },
                        "start_location": {
                            "lat": 28.6101001,
                            "lng": 77.22953919999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.7 km",
                            "value": 736
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 77
                        },
                        "end_location": {
                            "lat": 28.6006347,
                            "lng": 77.2180734
                        },
                        "html_instructions": "At the roundabout, take the <b>2nd</b> exit onto <b>Dr APJ Abdul Kalam Rd</b><div style=\"font-size:0.9em\">Pass by Embassy of Israel (on the left in 350m)</div>",
                        "maneuver": "roundabout-left",
                        "polyline": {
                            "points": "wtqmDy{ivMfBxANV@JAF?FAFA@A?A@A@A?A@A?Pb@LVBHPb@L`@@BN^Nb@L`@HRx@`CN`@LXXv@XbAZz@Rl@Pf@FPb@rAL^BPBHL^Vv@DNFLHTJRFHDHJP^^"
                        },
                        "start_location": {
                            "lat": 28.603805,
                            "lng": 77.22445189999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.2 km",
                            "value": 1194
                        },
                        "duration": {
                            "text": "3 mins",
                            "value": 157
                        },
                        "end_location": {
                            "lat": 28.5960115,
                            "lng": 77.20747260000002
                        },
                        "html_instructions": "At the roundabout, take the <b>2nd</b> exit and stay on <b>Dr APJ Abdul Kalam Rd</b><div style=\"font-size:0.9em\">Go through 1 roundabout</div>",
                        "maneuver": "roundabout-left",
                        "polyline": {
                            "points": "}`qmD}shvMFCF?F?F@F@DBFDBDDJ@D@DBD@F@HBN@HAHAJCHCHCDAP?J?L?F@D@B`@jAXx@v@zB\\dA\\bAZ~@`@fAb@vAd@lAb@rAj@vA^pAX|@\\dABHHLFHFFLPB@@?@?B@@?@@@@@?@@@@@B@@@@?B@@?@@B?@?B?@?B?@?@A@?B?@A@?@A@?@H^BL?HCJb@|@bAxCBHjCzHHLJTFPBFBJBLBL"
                        },
                        "start_location": {
                            "lat": 28.6006347,
                            "lng": 77.2180734
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.9 km",
                            "value": 867
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 118
                        },
                        "end_location": {
                            "lat": 28.5959908,
                            "lng": 77.19884379999999
                        },
                        "html_instructions": "Continue onto <b>Mustafa Kemal Attaturk Rd</b>",
                        "polyline": {
                            "points": "adpmDuqfvMBNM|@WhAABUvAKp@E^SpBEb@CVAZARAJAL?P?L@J?|@@x@@Z@\\Bh@Dr@Fv@BZBVF`@F^P|@Jf@?D@@Db@@P@N?L?LAd@APAl@CtC?`@A`@Ct@?T?F@DBDBDBFBBVR"
                        },
                        "start_location": {
                            "lat": 28.5960115,
                            "lng": 77.20747260000002
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.2 km",
                            "value": 246
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 32
                        },
                        "end_location": {
                            "lat": 28.5954841,
                            "lng": 77.1965074
                        },
                        "html_instructions": "At <b>Maharaja Ranjeet Singh Rd</b>, take the <b>2nd</b> exit onto <b>Panchsheel Marg</b>",
                        "maneuver": "roundabout-left",
                        "polyline": {
                            "points": "}cpmDw{dvMD@B@D@BBDBBBBB@BDHBF@H@H?HAHAHELAT?J@JBTDZJd@@HPnALbAD`A"
                        },
                        "start_location": {
                            "lat": 28.5959908,
                            "lng": 77.19884379999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.2 km",
                            "value": 1199
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 111
                        },
                        "end_location": {
                            "lat": 28.5853189,
                            "lng": 77.19316959999999
                        },
                        "html_instructions": "Turn <b>left</b> onto <b>Vinay Marg</b><div style=\"font-size:0.9em\">Pass by Indraprastha Gas Limited CNG Station (on the left in 500m)</div>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "w`pmDemdvMBBB@FLHJLJNNlBLx@BdDL|EN\\@~@BL@lCJf@BV@r@Nb@L~B~@zCnAbA`@NFpClAd@RnEfB|B~@HDTHPJNHVHDBF@F?D?LA"
                        },
                        "start_location": {
                            "lat": 28.5954841,
                            "lng": 77.1965074
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.7 km",
                            "value": 728
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 73
                        },
                        "end_location": {
                            "lat": 28.5795733,
                            "lng": 77.19000199999999
                        },
                        "html_instructions": "At the roundabout, take the <b>2nd</b> exit onto <b>Africa Ave</b><div style=\"font-size:0.9em\">Pass by Chanakya Bhavan (on the right in 350m)</div>",
                        "maneuver": "roundabout-left",
                        "polyline": {
                            "points": "ganmDixcvM@ABA@ABA@ABA@?BAD?BAB?B?B@B?B@@@B@B@@B@@BB@B@B?B@B?B?B@BAB?DPRDDFDFDNHNFnB`AXNxBfA~CzA~@d@~Ax@LFPH^P~@b@^RZLXJVJv@TZHf@NPBTHP@"
                        },
                        "start_location": {
                            "lat": 28.5853189,
                            "lng": 77.19316959999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.1 km",
                            "value": 1121
                        },
                        "duration": {
                            "text": "3 mins",
                            "value": 157
                        },
                        "end_location": {
                            "lat": 28.5696771,
                            "lng": 77.1897319
                        },
                        "html_instructions": "At the roundabout, take the <b>2nd</b> exit and stay on <b>Africa Ave</b>",
                        "maneuver": "roundabout-left",
                        "polyline": {
                            "points": "i}lmDodcvM?C?C@C?A@C@C@A@CBA@A@ABA@?B?@AB?B?@?B@@?B@@@@?@@@@@@@@@@?@@@@@RPFDJDTFF@L?r@At@Ct@AbBEz@C~@Ah@Ad@CzACxBIV@d@Bb@@x@@z@@hCHN?dCH~GLlCFfADhAFbA@"
                        },
                        "start_location": {
                            "lat": 28.5795733,
                            "lng": 77.19000199999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "2.1 km",
                            "value": 2134
                        },
                        "duration": {
                            "text": "6 mins",
                            "value": 350
                        },
                        "end_location": {
                            "lat": 28.5511765,
                            "lng": 77.1844172
                        },
                        "html_instructions": "Continue straight to stay on <b>Africa Ave</b><div style=\"font-size:0.9em\">Pass by the gas station (on the right)</div>",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "o_kmDybcvMt@FdAFr@Dx@F`AFt@Bz@F|APpCRL@vIl@|BNfBRhDb@RDB@L@V@`@Ft@N`ATpCr@NBl@RjBf@`Cn@zCx@DBhAXLDt@RjDz@hCn@RFxBh@jBj@RDFBjBf@jBb@~@RbCf@VDXH^J^N`@LRJTJPFNJPJVPb@TRN"
                        },
                        "start_location": {
                            "lat": 28.5696771,
                            "lng": 77.1897319
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.4 km",
                            "value": 355
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 45
                        },
                        "end_location": {
                            "lat": 28.5494691,
                            "lng": 77.1867912
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "{kgmDsabvMZHJBJDp@b@\\q@DM|@{Bp@qBzAcF"
                        },
                        "start_location": {
                            "lat": 28.5511765,
                            "lng": 77.1844172
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "35 m",
                            "value": 35
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 12
                        },
                        "end_location": {
                            "lat": 28.5497595,
                            "lng": 77.186919
                        },
                        "html_instructions": "Turn <b>left</b><div style=\"font-size:0.9em\">Restricted usage road</div>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "eagmDmpbvMy@Y"
                        },
                        "start_location": {
                            "lat": 28.5494691,
                            "lng": 77.1867912
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "30 m",
                            "value": 30
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 8
                        },
                        "end_location": {
                            "lat": 28.5498586,
                            "lng": 77.18663169999999
                        },
                        "html_instructions": "Turn <b>left</b><div style=\"font-size:0.9em\">Restricted usage road</div>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "_cgmDgqbvMSx@"
                        },
                        "start_location": {
                            "lat": 28.5497595,
                            "lng": 77.186919
                        },
                        "travel_mode": "DRIVING"
                    }
                ],
                "traffic_speed_entry": [],
                "via_waypoint": []
            }
        ],
        "overview_polyline": {
            "points": "wc{nDmzwuMZo@^CCg@s@_E]gA]MCSb@[G_@dAWlNoCtAYj@q@gg@zJyMdCik@tLkB\\CPEJ_HxAsJvBeAXGg@O}@hFeAzFkAhGsAxADdPgDlI_BtMsClQ_ExJkBnJgCbX{F|CgA|CgBxBgBzBgCrD}EvBoCdDiD~CgCrDwB`Bm@bD_A`B[lC]jKg@hUqAvJ[vFXdEbAfC`ArI|EhEvBvBn@bDf@nGJnVwApDUpBWj_@aFhWkDvJ}AfXwFlo@aOr_@sIt`AqTjUkFHMr@?b@OpAw@~@oA|BgF|AwERaB@}AOoB?]{@aCmAsCg@}Ae@yBY}BMaD?wKZ{Gv@qHh@{CrDoO`Nwg@`D{LlEuUdD_TjMwz@xByNnCePhLab@tPko@fKab@hC}H|ByEtCsFhAiBv@y@d@]|DsAtC{@nBM~AYzAS|DB~CV|CF`C[vFyArF_@zGuAvE[jFRfHj@~CFbCMlBFvMZxO^xIqA~X_@jCSvCq@`GiBrC_@hVs@bIQnGMv@W|BWzB]~@\\rAO|@WtAaAbAsAzA_AfAg@t@?vFjAnCVlOsChFoAfA]bFaB|C{@bFoG|@qC`@o@^WbAYtHe@nAYx@w@pAuBfB{EnCeH?aAAaD_AcDUiALgAJw@LwITw@l@o@dAm@jDiB`DkF~FkK|@{@vAe@hHWfDw@pC_ArDkBdIqEzEiCTMfU}LxJeGtCsC|CuBjEiBxDwArDeA~BMzBNdMvC`LpC|Bx@n@x@ZhA?rAMjAw@tE[pCCvB?t[Xr@r@\\tLRzCd@rDAlLExQKfBQlFeAvQcE|HaBrK_CtBm@TUn@[dA]`@k@?u@Wi@s@O_@D[ZM`@L`AbBjBtAdBpBzDd@~@f@lDVrDFbCSx@mAjC}CbJeBvE_ArCGp@H`AZzAhDpJbGzQh@p@d@R`@N~EJX@X?zF\\hAh@^\\p@vBpAxDfB|ELbA?t@Q~@g@rAaAfBBTJZPb@rBfBfMbIzOxKxEvDNr@MNlF~NxClJtArDPZf@Z^B`@t@Dl@Md@Ar@~@nC~GfSbClH\\h@^XLPDdABV^hA|ElNZz@FZIlA{@vEc@lEErD^|Hv@dFGhIEtBLXx@h@NX@f@Ix@VbBf@~EX^\\ZfDP`Nb@zERvA\\zGnCjGjClJvD~@b@b@?VM^BRXBNTb@rMrGzIhEfFvAH[VITF^^p@TlDG|O]~Vj@bJVhF\\f[xBpJjApUbGvQtErF|AfIdBfE~A`BbAdBv@rCmHzAcFy@YSx@"
        },
        "summary": "NH 44",
        "warnings": [],
        "waypoint_order": []
    },
    {
        "bounds": {
            "northeast": {
                "lat": 28.8330672,
                "lng": 77.1897319
            },
            "southwest": {
                "lat": 28.5494691,
                "lng": 77.1293031
            }
        },
        "copyrights": "Map data ©2024",
        "legs": [
            {
                "distance": {
                    "text": "41.6 km",
                    "value": 41640
                },
                "duration": {
                    "text": "1 hour 17 mins",
                    "value": 4602
                },
                "end_address": "IIT Hostel, Deer Park, Hauz Khas, New Delhi, Delhi 110016, India",
                "end_location": {
                    "lat": 28.5498586,
                    "lng": 77.18663169999999
                },
                "start_address": "R48J+6V, Garthi Khurad, Narela, Delhi, 110040, India",
                "start_location": {
                    "lat": 28.81612119999999,
                    "lng": 77.1320716
                },
                "steps": [
                    {
                        "distance": {
                            "text": "47 m",
                            "value": 47
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 6
                        },
                        "end_location": {
                            "lat": 28.8158195,
                            "lng": 77.1323261
                        },
                        "html_instructions": "Head <b>southeast</b>",
                        "polyline": {
                            "points": "wc{nDmzwuMLc@LK^C"
                        },
                        "start_location": {
                            "lat": 28.81612119999999,
                            "lng": 77.1320716
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.2 km",
                            "value": 158
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 43
                        },
                        "end_location": {
                            "lat": 28.81625439999999,
                            "lng": 77.13384599999999
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "{a{nDa|wuMCg@MmAe@qBS[Ik@"
                        },
                        "start_location": {
                            "lat": 28.8158195,
                            "lng": 77.1323261
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "53 m",
                            "value": 53
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 21
                        },
                        "end_location": {
                            "lat": 28.8162428,
                            "lng": 77.1341635
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "qd{nDqexuMQCKICK?G@EJKJEHC"
                        },
                        "start_location": {
                            "lat": 28.81625439999999,
                            "lng": 77.13384599999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "16 m",
                            "value": 16
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 19
                        },
                        "end_location": {
                            "lat": 28.8162818,
                            "lng": 77.1343213
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "od{nDogxuMG_@"
                        },
                        "start_location": {
                            "lat": 28.8162428,
                            "lng": 77.1341635
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.4 km",
                            "value": 409
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 48
                        },
                        "end_location": {
                            "lat": 28.8128112,
                            "lng": 77.13553809999999
                        },
                        "html_instructions": "Turn <b>right</b>",
                        "maneuver": "turn-right",
                        "polyline": {
                            "points": "wd{nDohxuMdAW|HaBnDm@l@If@OTOTa@"
                        },
                        "start_location": {
                            "lat": 28.8162818,
                            "lng": 77.1343213
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.9 km",
                            "value": 1890
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 149
                        },
                        "end_location": {
                            "lat": 28.82925,
                            "lng": 77.1306255
                        },
                        "html_instructions": "Sharp <b>left</b> onto <b>NH 44</b>",
                        "maneuver": "turn-sharp-left",
                        "polyline": {
                            "points": "aoznDcpxuMk[hGe@JcB\\qFfAkB^aAP}Dt@mB\\eCh@aEz@kDr@uFhAqBb@mFjAwDv@gCh@kB\\"
                        },
                        "start_location": {
                            "lat": 28.8128112,
                            "lng": 77.13553809999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.4 km",
                            "value": 437
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 40
                        },
                        "end_location": {
                            "lat": 28.8329462,
                            "lng": 77.1293031
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "yu}nDmqwuMCPAFCBGBo@L_B^gCf@eDv@iBZgAZ[FeAX"
                        },
                        "start_location": {
                            "lat": 28.82925,
                            "lng": 77.1306255
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.5 km",
                            "value": 535
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 50
                        },
                        "end_location": {
                            "lat": 28.8288604,
                            "lng": 77.1309279
                        },
                        "html_instructions": "Make a <b>U-turn</b>",
                        "maneuver": "uturn-right",
                        "polyline": {
                            "points": "}l~nDciwuMGg@Ig@EUdAWp@MxAYVEHCvBc@x@Q~@QdBa@ZGxBe@LCLAV?T@\\D"
                        },
                        "start_location": {
                            "lat": 28.8329462,
                            "lng": 77.1293031
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "10.6 km",
                            "value": 10583
                        },
                        "duration": {
                            "text": "13 mins",
                            "value": 794
                        },
                        "end_location": {
                            "lat": 28.7384746,
                            "lng": 77.15442089999999
                        },
                        "html_instructions": "Slight <b>left</b> onto <b>NH 44</b><div style=\"font-size:0.9em\">Pass by the gas station (on the left in 3.7 km)</div>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "ks}nDiswuMNCLCPEtAYh@KrBe@fB]xCo@jCm@x@O~@OfAQv@UbDm@|Bi@zBe@b@IdB]bB_@h@OjAUj@OTGfDy@xAY^IdCa@xBe@|Ae@zBm@d@MnBe@dASdAShCi@hB_@bAUxGwA\\Kf@Oz@W^MXMf@S`@Sd@Wn@_@d@[DETMnAeALMr@q@fAuA|ByCt@cARYV]Xa@p@u@r@y@XYPSdAaAZU\\[POrAeA~AeArAq@d@Sz@Yf@O\\Kr@Qh@QVEVGVGXEn@KRCZEl@GlAKr@ClCKzBKpDW\\ClCQD?j@CtCMhCOXAFAfBIpAGr@Cn@AB?l@A^?B?b@@R?lAFn@DH@d@BLBRBVF^HLD\\HD@`@Jd@Nn@RTHVLh@T~CbBj@\\^TfBdApCxAJFXJPHv@V~@VpATpAPpAH|@BdA?x@A|@CfRiATAr@GTCl@C|@Cn@Ib@GRCh@GNCNCf@G`@EVEpAQfC_@rL}AjGy@jC]dBSfBWtFw@dAOpASJATCFA\\EtASfAQ^GrCg@fAUbASXGHAJApBa@jH_BlE_AdE_AbGsAXG~HkBtDy@zEoAfH_Bn@OlCm@nDy@`AWzJyBpCm@DAhBa@TGVGHCHAxA[~@SdHcBtA[zCs@bN}Cf@K`B_@`@KdBa@nFsAn@O`IcBvEgA@AfMsCh@MHMr@?^E"
                        },
                        "start_location": {
                            "lat": 28.8288604,
                            "lng": 77.1309279
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "2.1 km",
                            "value": 2067
                        },
                        "duration": {
                            "text": "5 mins",
                            "value": 297
                        },
                        "end_location": {
                            "lat": 28.722681,
                            "lng": 77.165216
                        },
                        "html_instructions": "Continue straight to stay on <b>NH 44</b><div style=\"font-size:0.9em\">Pass by Metro Pillar Number 131 (on the right in 1.5 km)</div>",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "m~knDcf|uMdBMf@EdAIbAKb@Ib@Kh@QTILGJGLGJGNKJUlAm@z@k@nA{@|@o@bAm@|A{@lA_A`Au@|@w@TQz@}@PMx@k@rCgBrByAvCsBfD_Cd@]hFkDt@g@~AgAxAaArB_BxCoB`BeA\\UPOl@c@n@_@lAy@jAu@VSfAs@"
                        },
                        "start_location": {
                            "lat": 28.7384746,
                            "lng": 77.15442089999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.5 km",
                            "value": 1468
                        },
                        "duration": {
                            "text": "4 mins",
                            "value": 234
                        },
                        "end_location": {
                            "lat": 28.7122242,
                            "lng": 77.1743915
                        },
                        "html_instructions": "Continue straight to stay on <b>NH 44</b><div style=\"font-size:0.9em\">Pass by Metro Pillar Number 94 (on the right in 700m)</div>",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "w{hnDsi~uMTQdBeAh@c@DE~AyAhBaB`B{AJKPM~@{@n@g@d@a@pAgAz@u@LMDCfB{A|AmAHGXWZWnC}BrBeBtAiAb@]f@]@Ax@k@xBmBjC}BLKlBeBZYrAkAb@a@"
                        },
                        "start_location": {
                            "lat": 28.722681,
                            "lng": 77.165216
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.3 km",
                            "value": 269
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 80
                        },
                        "end_location": {
                            "lat": 28.7104246,
                            "lng": 77.1761813
                        },
                        "html_instructions": "Slight <b>left</b> onto <b>AH1</b>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "kzfnD}b`vMB[BEBEnB{AdBeBBC?APQFGb@a@POHKJGZU"
                        },
                        "start_location": {
                            "lat": 28.7122242,
                            "lng": 77.1743915
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "5.4 km",
                            "value": 5404
                        },
                        "duration": {
                            "text": "9 mins",
                            "value": 534
                        },
                        "end_location": {
                            "lat": 28.6768935,
                            "lng": 77.1411508
                        },
                        "html_instructions": "Turn <b>right</b> onto <b>Mahatma Gandhi Rd</b>/<wbr/><b>Ring Rd</b><div style=\"font-size:0.9em\">Pass by Celebration Banquet By Regalia (on the left in 2.1 km)</div>",
                        "maneuver": "turn-right",
                        "polyline": {
                            "points": "cofnDcn`vM\\YRQT\\@@V\\`@f@PRNLDDFDJJbA|@xCzBBBXRRRFJJPRPTNJJVRz@n@^V^VzBbBz@n@bBtAd@^RPZV\\ZTPRPPRNPXb@@@LRJRFLHN?@L`@Rt@Nf@Nf@BLBLRr@f@dBl@rB@D\\jAL`@Lb@^pARr@BLBHBJDLDJDNLb@X~@XdAFRDRNd@`@zAJ^HZLf@H`@Lh@Jf@H`@H`@\\dBr@pDHh@@FBJBH@F@FDZ^pBn@dDPx@P`An@|Cb@pBJ`@FPHLBDPVJLXj@PT~@t@BBZPh@RnAd@jAb@\\LlAf@NF~@^~Al@nAb@bBl@XJFBn@V`Cz@lC|@\\Pb@RbBt@B@HD@?@@B@HD@?HDjAb@d@J|@PXDlFbAF@~@NdGz@tAVjARp@Lf@RXLXRVRVVPNHJVZZ\\TZNTbCjEt@jAfAbBbBrCNVX`@`@r@@?fAhBz@vAR^T`@HJHNT^LTT^@?PZT^?@T^NVNTh@`ALR\\j@r@jA`C`Er@tAfA~ART^ZRRd@Z^Tj@VVLNDNDbB`@b@H`@FfB`@h@JtATRDNDh@Lj@N"
                        },
                        "start_location": {
                            "lat": 28.7104246,
                            "lng": 77.1761813
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.9 km",
                            "value": 861
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 68
                        },
                        "end_location": {
                            "lat": 28.6696595,
                            "lng": 77.1381561
                        },
                        "html_instructions": "Keep <b>right</b> to continue on <b>Mahatma Gandhi Rd</b>/<wbr/><b>Punjabi Bagh Flyover</b>/<wbr/><b>Ring Rd</b>/<wbr/><b>Shri Hans Maharaj Setu Flyover</b>",
                        "maneuver": "keep-right",
                        "polyline": {
                            "points": "q}_nDesyuMd@Jx@Rl@JjB\\XDXFdARp@ND@\\H|A\\XHVDZJXH\\J\\HPF`@Jf@RHBHB\\LB?\\JB@VHHBXJf@Pj@PVHbBh@PDv@Zp@ZJFZP^T|@r@VR"
                        },
                        "start_location": {
                            "lat": 28.6768935,
                            "lng": 77.1411508
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.2 km",
                            "value": 192
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 43
                        },
                        "end_location": {
                            "lat": 28.6683838,
                            "lng": 77.1368821
                        },
                        "html_instructions": "Keep <b>left</b>",
                        "maneuver": "keep-left",
                        "polyline": {
                            "points": "kp~mDo`yuMj@Jr@p@Z`@LPHJhAvARXLN"
                        },
                        "start_location": {
                            "lat": 28.6696595,
                            "lng": 77.1381561
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.8 km",
                            "value": 1807
                        },
                        "duration": {
                            "text": "4 mins",
                            "value": 211
                        },
                        "end_location": {
                            "lat": 28.6570695,
                            "lng": 77.14949759999999
                        },
                        "html_instructions": "Turn <b>left</b> onto <b>Patel Rd</b>/<wbr/><b>Shiv Das Puri Marg</b><div style=\"font-size:0.9em\">Continue to follow Patel Rd</div>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "kh~mDoxxuMVCPE\\OLEJWZm@N[Ti@b@g@\\]NMTSh@g@xAu@PGRKjAs@PK~@k@jAs@d@Y^UhAs@TMDCNMxGkEVQ~CoBx@i@PSXWZ]l@_A|@qAHMd@s@\\s@n@}AHQFOJSDKFMFOFODMDODKV{@L[FKHSFQLYLYL[HOFQv@{ADIlAiCv@_BR_@h@_ApAqC\\q@"
                        },
                        "start_location": {
                            "lat": 28.6683838,
                            "lng": 77.1368821
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "3.0 km",
                            "value": 2963
                        },
                        "duration": {
                            "text": "8 mins",
                            "value": 470
                        },
                        "end_location": {
                            "lat": 28.6419544,
                            "lng": 77.1744855
                        },
                        "html_instructions": "Continue straight onto <b>Main Mathura Rd</b>/<wbr/><b>Patel Rd</b><div style=\"font-size:0.9em\">Pass by Metro Pillar Number 210 (on the right in 1.7 km)</div>",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "ua|mDkg{uMJQTe@?AZe@pA}Br@sA|@aBLSJQ@CNWt@oATe@Tg@R]P]d@eAd@cAJUJWjA{BJUHSp@_AHMlAeCz@gBbBiDNUjAgCr@_Bh@gAVg@@ABGDGNYx@}AnByDBGjAyB^w@tAmCVe@jByDHOz@cBTa@P]jAaCBE`AkBv@_Bz@eBd@aAVi@P[Ra@h@cAR_@f@cAr@sAJSf@cA`@w@P]d@}@LUd@}@~A_Dd@_Al@oAf@eAf@cAh@cAP_@Tc@f@_A@AN[f@kABGT[@CV]f@q@"
                        },
                        "start_location": {
                            "lat": 28.6570695,
                            "lng": 77.14949759999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.9 km",
                            "value": 920
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 147
                        },
                        "end_location": {
                            "lat": 28.6341691,
                            "lng": 77.17415559999999
                        },
                        "html_instructions": "At <b>Chaudhary Brahm Prakash Chowk</b>/<wbr/><b>Patel Nagar Roundabout</b>, take the <b>3rd</b> exit onto <b>Dev Prakash Shastri Marg</b>/<wbr/><b>Dr KS Krishnan Marg</b><div style=\"font-size:0.9em\">Pass by the gas station (on the right in 300m)</div>",
                        "maneuver": "roundabout-left",
                        "polyline": {
                            "points": "ecymDqc`vMAC?C?AAA?C?A?C?A@A?A?C?A@A?A?C@??A@A?A?A@?@A?A@CBC@ABC@ABCB?BA?A@?@?@A@?@?@?@?B?B@D@B?JBBDBHBHHCD?B?B?F@v@X\\NVH@@NDRDVFPFB?LBJBR@N?P?PAVEPEVGPGRITIb@ONCn@Ip@Ef@An@Bt@@p@DdBJR@XBlCP`DRhAHp@Jr@H^FL@"
                        },
                        "start_location": {
                            "lat": 28.6419544,
                            "lng": 77.1744855
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.4 km",
                            "value": 1401
                        },
                        "duration": {
                            "text": "3 mins",
                            "value": 154
                        },
                        "end_location": {
                            "lat": 28.62405,
                            "lng": 77.1804603
                        },
                        "html_instructions": "Turn <b>left</b> onto <b>Prof Ram Nath Vij Marg</b><div style=\"font-size:0.9em\">Pass by Sai Mandir (on the right in 650m)</div>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "qrwmDoa`vMn@Cd@@L@LBF?F?H?F@HMJMLOLqCJBP@^@z@FP@d@BL?\\AFAHEFEHGHGNOTQh@Un@YREJCRCl@E\\ChBOtBOb@CBAjCQNCHALEJERKb@Uf@Y^QRKRIZMLGJGHIJIRWLM@APQFIHGFEh@Wr@c@j@a@HIFEDEDGBE@AFMLWPc@`@gAP_@FMHMHMLUT]~@oAPUlBsC"
                        },
                        "start_location": {
                            "lat": 28.6341691,
                            "lng": 77.17415559999999
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "37 m",
                            "value": 37
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 17
                        },
                        "end_location": {
                            "lat": 28.6238211,
                            "lng": 77.180739
                        },
                        "html_instructions": "Continue straight to stay on <b>Prof Ram Nath Vij Marg</b>",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "isumD{havMl@w@"
                        },
                        "start_location": {
                            "lat": 28.62405,
                            "lng": 77.1804603
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "3.4 km",
                            "value": 3441
                        },
                        "duration": {
                            "text": "6 mins",
                            "value": 332
                        },
                        "end_location": {
                            "lat": 28.5965585,
                            "lng": 77.1663844
                        },
                        "html_instructions": "Turn <b>right</b> onto <b>Vande Mataram Marg</b><div style=\"font-size:0.9em\">Pass by Metro Pillar Number 46 (on the right in 2.8 km)</div>",
                        "maneuver": "turn-right",
                        "polyline": {
                            "points": "{qumDsjavMNQJPtCxE^h@NTTT\\^f@d@^ZbDhChBzAPLvAhA\\ZPNTPPJRL`AXPBP@R@n@BxADzAFb@Bd@Bl@Jj@Ll@P`A`@F@XN~@f@vAr@hBz@DBj@Tb@LNFN@ZF\\Bf@@Z?vAEfBE`C?^B\\FZHh@RhAr@rCbC\\XdElDJLbCjBdBtAj@Vh@R`B\\~Bh@@@n@Lf@Nn@T~@`@bEhB^PfBx@rFlCLHTL^RlBhA|Av@pBbAJDtB|@`A`@^PB@\\HTFZHRB`@F@?VBPBbBLb@BdBLLBFDDBFFXZPDNDNDJBDBp@T"
                        },
                        "start_location": {
                            "lat": 28.6238211,
                            "lng": 77.180739
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.5 km",
                            "value": 523
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 55
                        },
                        "end_location": {
                            "lat": 28.5928322,
                            "lng": 77.1683848
                        },
                        "html_instructions": "Slight <b>left</b>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "ogpmD{p~uM|@FdA?J?b@A^?VCl@C`@GHCDCDCLGTKDCJIZSVSPOFKHMDQDO@OBc@@]@M@I@E?A@?TKGMT[HKHGHGLGFCHEJAJELCREHAL?P?JBZ@"
                        },
                        "start_location": {
                            "lat": 28.5965585,
                            "lng": 77.1663844
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.5 km",
                            "value": 1535
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 144
                        },
                        "end_location": {
                            "lat": 28.5806876,
                            "lng": 77.1749344
                        },
                        "html_instructions": "Take the ramp onto <b>NH 48</b><div style=\"font-size:0.9em\">Pass by the gas station (on the left in 700m)</div>",
                        "polyline": {
                            "points": "epomDk}~uMXFH@FBDBDBLJ\\V@?RJD@B@H@H@D?F?FAFADAHADCJEf@Y^WZOZIV?HGzCoBvG{Dd@[^UfAo@HGVMpBkAVONIPKp@]x@i@p@_@l@_@|@g@v@_@FEVM|BgARMPGVM~@c@`Ae@h@StAs@zAs@jB_A|BgAh@]JEtAm@"
                        },
                        "start_location": {
                            "lat": 28.5928322,
                            "lng": 77.1683848
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "1.7 km",
                            "value": 1738
                        },
                        "duration": {
                            "text": "2 mins",
                            "value": 139
                        },
                        "end_location": {
                            "lat": 28.5700017,
                            "lng": 77.1863674
                        },
                        "html_instructions": "Keep <b>right</b> to stay on <b>NH 48</b>",
                        "maneuver": "keep-right",
                        "polyline": {
                            "points": "idmmDif`vMz@_@dAi@vBaA\\QTIRK`@QHEZM~@e@FC`@QRKTK\\ObCoAp@[b@Ul@Yl@[t@c@nCuAf@Y`B{@x@c@h@WvBqAl@_@^Yp@m@bAaATSVYp@}@v@iAh@aAdAuBzBqFb@oALg@Li@Da@Dm@H_BN{CDgA@a@?GDq@"
                        },
                        "start_location": {
                            "lat": 28.5806876,
                            "lng": 77.1749344
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "81 m",
                            "value": 81
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 12
                        },
                        "end_location": {
                            "lat": 28.5699955,
                            "lng": 77.1871843
                        },
                        "html_instructions": "Slight <b>left</b> toward <b>Bikaji Cama Place Flyover</b><div style=\"font-size:0.9em\">Pass by the gas station (on the left)</div>",
                        "maneuver": "turn-slight-left",
                        "polyline": {
                            "points": "oakmDymbvMCKAEAE@M?[D_B"
                        },
                        "start_location": {
                            "lat": 28.5700017,
                            "lng": 77.1863674
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.1 km",
                            "value": 148
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 30
                        },
                        "end_location": {
                            "lat": 28.5698098,
                            "lng": 77.188688
                        },
                        "html_instructions": "Continue onto <b>Bikaji Cama Place Flyover</b>",
                        "polyline": {
                            "points": "oakmD{rbvMPiCFoADm@De@"
                        },
                        "start_location": {
                            "lat": 28.5699955,
                            "lng": 77.1871843
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "93 m",
                            "value": 93
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 35
                        },
                        "end_location": {
                            "lat": 28.5696834,
                            "lng": 77.1896324
                        },
                        "html_instructions": "Continue straight",
                        "maneuver": "straight",
                        "polyline": {
                            "points": "i`kmDi|bvMBQBg@Bc@L}A"
                        },
                        "start_location": {
                            "lat": 28.5698098,
                            "lng": 77.188688
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "2.1 km",
                            "value": 2144
                        },
                        "duration": {
                            "text": "6 mins",
                            "value": 365
                        },
                        "end_location": {
                            "lat": 28.5511765,
                            "lng": 77.1844172
                        },
                        "html_instructions": "Turn <b>right</b> onto <b>Africa Ave</b><div style=\"font-size:0.9em\">Pass by the gas station (on the right)</div>",
                        "maneuver": "turn-right",
                        "polyline": {
                            "points": "o_kmDebcvM?St@FdAFr@Dx@F`AFt@Bz@F|APpCRL@vIl@|BNfBRhDb@RDB@L@V@`@Ft@N`ATpCr@NBl@RjBf@`Cn@zCx@DBhAXLDt@RjDz@hCn@RFxBh@jBj@RDFBjBf@jBb@~@RbCf@VDXH^J^N`@LRJTJPFNJPJVPb@TRN"
                        },
                        "start_location": {
                            "lat": 28.5696834,
                            "lng": 77.1896324
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "0.4 km",
                            "value": 355
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 45
                        },
                        "end_location": {
                            "lat": 28.5494691,
                            "lng": 77.1867912
                        },
                        "html_instructions": "Turn <b>left</b>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "{kgmDsabvMZHJBJDp@b@\\q@DM|@{Bp@qBzAcF"
                        },
                        "start_location": {
                            "lat": 28.5511765,
                            "lng": 77.1844172
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "35 m",
                            "value": 35
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 12
                        },
                        "end_location": {
                            "lat": 28.5497595,
                            "lng": 77.186919
                        },
                        "html_instructions": "Turn <b>left</b><div style=\"font-size:0.9em\">Restricted usage road</div>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "eagmDmpbvMy@Y"
                        },
                        "start_location": {
                            "lat": 28.5494691,
                            "lng": 77.1867912
                        },
                        "travel_mode": "DRIVING"
                    },
                    {
                        "distance": {
                            "text": "30 m",
                            "value": 30
                        },
                        "duration": {
                            "text": "1 min",
                            "value": 8
                        },
                        "end_location": {
                            "lat": 28.5498586,
                            "lng": 77.18663169999999
                        },
                        "html_instructions": "Turn <b>left</b><div style=\"font-size:0.9em\">Restricted usage road</div>",
                        "maneuver": "turn-left",
                        "polyline": {
                            "points": "_cgmDgqbvMSx@"
                        },
                        "start_location": {
                            "lat": 28.5497595,
                            "lng": 77.186919
                        },
                        "travel_mode": "DRIVING"
                    }
                ],
                "traffic_speed_entry": [],
                "via_waypoint": []
            }
        ],
        "overview_polyline": {
            "points": "wc{nDmzwuMZo@^CCg@MmAe@qB]gA]MCSb@[G_@dAWlNoCtAYj@q@gg@zJyMdCik@tLkB\\CPEJ_HxAoGrAcBb@eAXGg@O}@hFeAzFkAhGsAxADdPgDlI_BtMsClQ_ExJkBnJgC~JqBbLiC|CgA|CgBxBgBzBgCrD}EvBoCdDiD~CgCrDwB`Bm@bD_A`B[lC]jKg@bJm@dJc@tFW`CChCHlBNdEbAfC`ArI|EhEvBvBn@bDf@nCL~BAnVwApDUpBWj_@aFhWkDvJ}AfXwFbXgGhVyFr_@sI|UqFvi@_MjUkFHMr@?dCStEe@pBo@t@c@JUlAm@jCgBlHyEpE}Db\\yTtCoBlEaDjH{ErMsIxLwK|LcKdNaL`IyGvCkCvBmBFa@rBaBhBiB|@}@bAy@p@k@V^zAfB|AtAjEfD|@~@~BfBzH`GrBdBjAhAt@lArAfE~C|K`FjQzAzGfBfJnEfU`@fAhAfBbAx@dAd@xDvArM~E|IbDtCpAhBr@jJfBbLdB|B`@`A`@zAnArA`BpGpKhIbNzFtJfGnKzAtBr@n@hCvAfDv@hGjAxBh@dLzBfGzAnDfAhEtAtBn@hBv@dCbBVRj@JnArAtBnCLNVCn@UX]j@iAx@qAl@k@~@{@jB}@pDwBzEwCdIkFvDaCjA}@t@u@jBqCn@aAlAqCb@aA\\{@xA_EpFgLlDcH|@_BdHeMtDaIvAqCz@sAvFeL|E_KbWag@lOmZxNqY|@wAAIBS\\c@NENBVRBHHCH?`Bj@xBj@`ADrAU~Ak@xCU|FV|Ij@nEf@pB@f@BPKX]LqCJBp@B`CLv@Ox@q@xBy@hE]hHg@r@QbEqBn@c@b@g@j@i@rCgBVYh@kAdAcClBqC|DsFpEjHzBvBvJ|HvAhAtAf@b@DxFRhAFxAXpCdAfGzCnBl@|BL~DK`DBx@PrBfAbKxIhF`EtAj@rGvAzIpDhKbF`GbDtHhDvAd@rATpDXrBPLH`@b@`@JrAb@bCFn@AfCOb@SbAm@z@}@PuAF{@VMGMT[RSh@Yx@Qt@@fANvAz@`@B^GxA{@v@Y`@GrLkHdAq@zEqCbIuErIcE|GaD~GkDxLsFvEwBbPkI|HiElAy@tBoBl@m@hBgCnBwD~CaIZqAJoA`@eJ?kADoC~@iN?St@FxBLlFZtQtAdFb@|Dh@h@DjH`BdPlE`SfFzKfCpBj@|Al@|A~@fAb@p@b@\\q@bAiClCuIy@YSx@"
        },
        "summary": "AH1",
        "warnings": [],
        "waypoint_order": []
    }
]

function safetyScore(node) {
    //check if node is in unsafe location
    let min_distance=1000000000, safety_score=0;
    data.forEach((element) => {
        // calculate distance between node and element
        let distance = Math.sqrt(Math.pow(node.lat - element.lati, 2) + Math.pow(node.lng - element.longi, 2));
        if(distance<min_distance){
            min_distance=distance;
            safety_score=element.properties.mag;
        }
    });
    return safety_score
}

let min_safety_score=5.0;
let min_safety_node=0;


routeDetails.forEach((route, index) => {
    let avg_safety_score=0.0;
    let sum_safety_score=0;
    let danger_polyline=[];
    route.legs[0].steps.forEach((step, index) => {
        let safety_score=safetyScore(step.end_location)
        step.safety_score=safety_score;
        if(safetyScore>=3){
            step.unsafe=true;
            danger_polyline.push(step.polyline);
        }
        else{
            step.unsafe=false;
        }
        sum_safety_score+=safety_score;
    });
    avg_safety_score=sum_safety_score/route.legs[0].steps.length;
    route.safety_score=avg_safety_score;
    route.danger_polyline=danger_polyline;
    if(avg_safety_score<min_safety_score){
        min_safety_score=avg_safety_score;
        min_safety_node=index;
    }
});

console.log(routeDetails[min_safety_node])