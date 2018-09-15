import fisica.*;

int count = 505;
FWorld world;
ArrayList<PVector> points;

void setup() {
  size(400, 400, P2D);
  smooth(8);
  points = new ArrayList<PVector>();

  ///// Ugly hard coded points
  points.add(new PVector(0.0, height-129.9127));
  points.add(new PVector(13.9893, height-137.1699));
  points.add(new PVector(27.9785, height-144.4271));
  points.add(new PVector(41.9678, height-151.6843));
  points.add(new PVector(55.9571, height-158.9416));
  points.add(new PVector(69.9463, height-166.1988));
  points.add(new PVector(83.9356, height-173.456));
  points.add(new PVector(97.9249, height-180.7132));
  points.add(new PVector(110.3774, height-189.947));
  points.add(new PVector(120.8585, height-201.7161));
  points.add(new PVector(131.3397, height-213.4852));
  points.add(new PVector(141.8209, height-225.2543));
  points.add(new PVector(152.302, height-237.0234));
  points.add(new PVector(162.7832, height-248.7925));
  points.add(new PVector(173.2644, height-260.5616));
  points.add(new PVector(183.7455, height-272.3308));
  points.add(new PVector(194.2267, height-284.0999));
  points.add(new PVector(204.7079, height-295.869));
  points.add(new PVector(215.189, height-307.6381));
  points.add(new PVector(225.6702, height-319.4072));
  points.add(new PVector(236.1514, height-331.1763));
  points.add(new PVector(246.6325, height-342.9454));
  points.add(new PVector(254.0992, height-356.6419));
  points.add(new PVector(260.383, height-371.0946));
  points.add(new PVector(266.6668, height-385.5473));
  points.add(new PVector(272.9506, height-400.0));


  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 0);
}

void draw() {
  background(255);
  if (frameCount%10==0) {
    if (count > 0) {
      //Setting up difference emitters
      addBox(328, 30);
      addBox(width/2+40, height/2);
      addBox(113, 329);

      addBox(206, 280);
      addBox(296, 118);
      addBox(15, 338);
      count -= 1;
    }
  }
  
  //Drawing black fill for the edge
  beginShape();
  fill(25);
  vertex(0, 0);
  fill(15);
  for (PVector P : points) {
    vertex(P.x, P.y);
  }
  endShape();

  //Repel boxes away from edge
  for (Object b : world.getBodies()) {
    FBody a = (FBody) b;
    PVector pos = new PVector(a.getX(), a.getY());
    ArrayList<Float> distances = new ArrayList<Float>();
    for (PVector p : points) {
      distances.add(PVector.dist(p, pos));
    }
    int index = getMinP(distances);
    //Directed towards closest point
    PVector vec = PVector.sub(pos, points.get(index));

    //Directed towards mouse position
    //PVector vec = PVector.sub(pos,new PVector(mouseX,mouseY));

    float ang = atan2(vec.y, vec.x);
    //a.setAngularVelocity(0);
    PVector vecNormed = vec.copy().normalize().mult(15);
    a.setVelocity(vecNormed.x, vecNormed.y);
    a.setRotation(ang);
  }

  world.step();
  world.draw();

  //Draw ugly, hardcoded lines. 
  drawLines();
}
void addBox(float x, float y) {

  if (random(1)>0.8) {
    FBox box = new FBox(random(5, 20), random(5, 20));
    box.setPosition( x, y);
    box.setFill(255);
    box.setStrokeWeight(random(2));
    box.setStroke(255);
    world.add(box);
  } else {
    FBox box = new FBox(random(5, 20), random(5, 20));
    box.setPosition( x, y);
    box.setFill(0);
    box.setStrokeWeight(random(2));
    box.setStroke(255);
    world.add(box);
  }
}

float getMin(ArrayList<Float> list) {
  float minN = 100000000.0;
  int minPos = -1;
  for (int i = 0; i < list.size(); i++) {
    float value = list.get(i);
    if (value < minN) {
      minN = value;
      minPos = i;
    }
  }
  return minN;
}
int getMinP(ArrayList<Float> list) {
  float minN = 100000000.0;
  int minPos = -1;
  for (int i = 0; i < list.size(); i++) {
    float value = list.get(i);
    if (value < minN) {
      minN = value;
      minPos = i;
    }
  }
  return minPos;
}

void drawLines() {
  /*
  Not proud of this approach, but needed to do something quick and dirty. 
   */
  pushStyle();
  noFill();
  stroke(255);
  strokeWeight(1);
  beginShape();
  vertex(-5.7319, height-136.7067);
  vertex(24.0078, height-151.4561);
  vertex(53.7474, height-166.2055);
  vertex(88.9349, height-183.6567);
  vertex(94.3827, height-186.3585);
  vertex(100.6125, height-189.4482);
  vertex(101.3945, height-189.836);
  vertex(102.1765, height-190.2238);
  vertex(102.1916, height-190.2313);
  vertex(102.2034, height-190.2415);
  vertex(102.2147, height-190.2533);
  vertex(102.2507, height-190.294);
  vertex(102.2867, height-190.3346);
  vertex(102.4916, height-190.5661);
  vertex(102.6605, height-190.757);
  vertex(108.7966, height-197.6905);
  vertex(114.7638, height-204.4332);
  vertex(131.3828, height-223.2118);
  vertex(142.0346, height-235.2479);
  vertex(173.9924, height-271.3587);
  vertex(195.2984, height-295.4335);
  vertex(222.9861, height-326.7193);
  vertex(229.3679, height-333.9304);
  vertex(237.4233, height-343.0326);
  vertex(239.0969, height-344.9238);
  vertex(241.1939, height-347.2933);
  vertex(241.6172, height-347.7716);
  vertex(242.2089, height-348.4402);
  vertex(242.3779, height-348.6298);
  vertex(242.5455, height-348.8206);
  vertex(242.5462, height-348.8214);
  vertex(242.5465, height-348.8223);
  vertex(242.5469, height-348.8233);
  vertex(242.5514, height-348.8342);
  vertex(242.5558, height-348.8451);
  vertex(242.6323, height-349.033);
  vertex(242.7043, height-349.21);
  vertex(243.9273, height-352.2142);
  vertex(245.0783, height-355.0415);
  vertex(252.7206, height-373.8145);
  vertex(259.212, height-389.7604);
  vertex(265.7034, height-405.7062);
  endShape();
  stroke(255, 200);
  beginShape();
  vertex(-11.4638, height-143.5008);
  vertex(18.866, height-157.8775);
  vertex(49.1957, height-172.2543);
  vertex(85.0814, height-189.2647);
  vertex(90.6373, height-191.8983);
  vertex(96.9907, height-194.9099);
  vertex(97.7882, height-195.288);
  vertex(98.5857, height-195.666);
  vertex(98.601, height-195.6733);
  vertex(98.6133, height-195.6831);
  vertex(98.6251, height-195.6945);
  vertex(98.6601, height-195.7344);
  vertex(98.6952, height-195.7743);
  vertex(98.8951, height-196.0016);
  vertex(99.0598, height-196.1891);
  vertex(105.0451, height-202.9966);
  vertex(110.8655, height-209.6166);
  vertex(127.0759, height-228.054);
  vertex(137.4658, height-239.8712);
  vertex(168.6378, height-275.3257);
  vertex(189.4199, height-298.9628);
  vertex(216.4268, height-329.68);
  vertex(222.6517, height-336.76);
  vertex(230.509, height-345.6968);
  vertex(232.1415, height-347.5536);
  vertex(234.1869, height-349.88);
  vertex(234.5998, height-350.3496);
  vertex(235.1769, height-351.006);
  vertex(235.3418, height-351.1922);
  vertex(235.5053, height-351.3796);
  vertex(235.5059, height-351.3804);
  vertex(235.5063, height-351.3814);
  vertex(235.5067, height-351.3824);
  vertex(235.5111, height-351.3939);
  vertex(235.5155, height-351.4054);
  vertex(235.5913, height-351.6037);
  vertex(235.6627, height-351.7905);
  vertex(236.8748, height-354.9609);
  vertex(238.0154, height-357.9446);
  vertex(245.5895, height-377.7563);
  vertex(252.0228, height-394.5843);
  vertex(258.4562, height-411.4124);
  endShape();
  stroke(255, 150);
  beginShape();
  vertex(-17.1957, height-150.2948);
  vertex(13.7242, height-164.299);
  vertex(44.644, height-178.3032);
  vertex(81.2278, height-194.8728);
  vertex(86.8918, height-197.4381);
  vertex(93.3688, height-200.3717);
  vertex(94.1818, height-200.7399);
  vertex(94.9949, height-201.1082);
  vertex(95.0105, height-201.1153);
  vertex(95.0231, height-201.1248);
  vertex(95.0354, height-201.1358);
  vertex(95.0696, height-201.1749);
  vertex(95.1038, height-201.2141);
  vertex(95.2986, height-201.4372);
  vertex(95.4592, height-201.6211);
  vertex(101.2936, height-208.3026);
  vertex(106.9673, height-214.8001);
  vertex(122.769, height-232.8961);
  vertex(132.897, height-244.4946);
  vertex(163.2832, height-279.2927);
  vertex(183.5414, height-302.4922);
  vertex(209.8675, height-332.6407);
  vertex(215.9354, height-339.5897);
  vertex(223.5947, height-348.361);
  vertex(225.1861, height-350.1834);
  vertex(227.1799, height-352.4667);
  vertex(227.5824, height-352.9277);
  vertex(228.145, height-353.5719);
  vertex(228.3056, height-353.7547);
  vertex(228.4651, height-353.9385);
  vertex(228.4657, height-353.9395);
  vertex(228.466, height-353.9405);
  vertex(228.4664, height-353.9416);
  vertex(228.4708, height-353.9537);
  vertex(228.4751, height-353.9658);
  vertex(228.5503, height-354.1744);
  vertex(228.621, height-354.371);
  vertex(229.8222, height-357.7077);
  vertex(230.9525, height-360.8478);
  vertex(238.4583, height-381.6981);
  vertex(244.8337, height-399.4083);
  vertex(251.209, height-417.1185);

  endShape();
  stroke(255, 150);
  beginShape();
  vertex(-22.9275, height-157.0888);
  vertex(8.5824, height-170.7205);
  vertex(40.0922, height-184.3521);
  vertex(77.3742, height-200.4808);
  vertex(83.1463, height-202.9779);
  vertex(89.747, height-205.8334);
  vertex(90.5755, height-206.1919);
  vertex(91.404, height-206.5503);
  vertex(91.4199, height-206.5572);
  vertex(91.433, height-206.5664);
  vertex(91.4457, height-206.577);
  vertex(91.479, height-206.6154);
  vertex(91.5123, height-206.6538);
  vertex(91.7021, height-206.8727);
  vertex(91.8586, height-207.0532);
  vertex(97.542, height-213.6086);
  vertex(103.069, height-219.9836);
  vertex(118.4621, height-237.7382);
  vertex(128.3282, height-249.118);
  vertex(157.9286, height-283.2596);
  vertex(177.6629, height-306.0216);
  vertex(203.3082, height-335.6014);
  vertex(209.2192, height-342.4193);
  vertex(216.6804, height-351.0252);
  vertex(218.2306, height-352.8132);
  vertex(220.1729, height-355.0535);
  vertex(220.565, height-355.5057);
  vertex(221.113, height-356.1378);
  vertex(221.2695, height-356.3171);
  vertex(221.4248, height-356.4975);
  vertex(221.4254, height-356.4985);
  vertex(221.4258, height-356.4996);
  vertex(221.4262, height-356.5007);
  vertex(221.4305, height-356.5134);
  vertex(221.4348, height-356.5261);
  vertex(221.5092, height-356.7452);
  vertex(221.5794, height-356.9515);
  vertex(222.7696, height-360.4544);
  vertex(223.8897, height-363.7509);
  vertex(231.3271, height-385.6399);
  vertex(237.6445, height-404.2323);
  vertex(243.9618, height-422.8247);

  endShape();
  stroke(255, 100);
  beginShape();
  vertex(-28.6594, height-163.8829);
  vertex(3.4405, height-177.1419);
  vertex(35.5405, height-190.401);
  vertex(73.5207, height-206.0889);
  vertex(79.4009, height-208.5177);
  vertex(86.1251, height-211.2952);
  vertex(86.9692, height-211.6438);
  vertex(87.8132, height-211.9925);
  vertex(87.8293, height-211.9992);
  vertex(87.8429, height-212.008);
  vertex(87.856, height-212.0182);
  vertex(87.8884, height-212.0559);
  vertex(87.9208, height-212.0936);
  vertex(88.1056, height-212.3082);
  vertex(88.2579, height-212.4853);
  vertex(93.7905, height-218.9147);
  vertex(99.1708, height-225.1671);
  vertex(114.1552, height-242.5804);
  vertex(123.7594, height-253.7413);
  vertex(152.574, height-287.2266);
  vertex(171.7844, height-309.551);
  vertex(196.7489, height-338.5621);
  vertex(202.503, height-345.2489);
  vertex(209.7661, height-353.6894);
  vertex(211.2752, height-355.443);
  vertex(213.1659, height-357.6402);
  vertex(213.5476, height-358.0838);
  vertex(214.0811, height-358.7037);
  vertex(214.2334, height-358.8796);
  vertex(214.3846, height-359.0565);
  vertex(214.3852, height-359.0575);
  vertex(214.3855, height-359.0587);
  vertex(214.3859, height-359.0598);
  vertex(214.3902, height-359.0731);
  vertex(214.3945, height-359.0864);
  vertex(214.4682, height-359.3159);
  vertex(214.5377, height-359.5321);
  vertex(215.717, height-363.2011);
  vertex(216.8268, height-366.6541);
  vertex(224.1959, height-389.5816);
  vertex(230.4553, height-409.0563);
  vertex(236.7146, height-428.5309);
  endShape();

  stroke(255, 50);
  beginShape();
  vertex(-34.3913, height-170.6769);
  vertex(-1.7013, height-183.5634);
  vertex(30.9888, height-196.4499);
  vertex(69.6671, height-211.6969);
  vertex(75.6554, height-214.0575);
  vertex(82.5032, height-216.7569);
  vertex(83.3628, height-217.0958);
  vertex(84.2224, height-217.4346);
  vertex(84.2388, height-217.4411);
  vertex(84.2527, height-217.4497);
  vertex(84.2663, height-217.4594);
  vertex(84.2979, height-217.4964);
  vertex(84.3294, height-217.5333);
  vertex(84.5091, height-217.7438);
  vertex(84.6573, height-217.9173);
  vertex(90.039, height-224.2207);
  vertex(95.2725, height-230.3505);
  vertex(109.8483, height-247.4225);
  vertex(119.1906, height-258.3647);
  vertex(147.2194, height-291.1936);
  vertex(165.9059, height-313.0804);
  vertex(190.1896, height-341.5228);
  vertex(195.7868, height-348.0785);
  vertex(202.8519, height-356.3535);
  vertex(204.3198, height-358.0728);
  vertex(206.1589, height-360.2269);
  vertex(206.5302, height-360.6618);
  vertex(207.0491, height-361.2696);
  vertex(207.1973, height-361.4421);
  vertex(207.3444, height-361.6155);
  vertex(207.3449, height-361.6166);
  vertex(207.3453, height-361.6177);
  vertex(207.3457, height-361.619);
  vertex(207.3499, height-361.6329);
  vertex(207.3541, height-361.6468);
  vertex(207.4272, height-361.8866);
  vertex(207.496, height-362.1126);
  vertex(208.6644, height-365.9479);
  vertex(209.7639, height-369.5572);
  vertex(217.0648, height-393.5234);
  vertex(223.2661, height-413.8802);
  vertex(229.4674, height-434.2371);
  endShape();
  popStyle();
}
