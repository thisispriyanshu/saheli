const data = require('./data/data.json');


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



function safeRouteJson(routeDetails){
    let min_safety_score=5.0;
    let min_safety_node=0;
    let result=[];
    routeDetails.forEach((route, index) => {
    let avg_safety_score=0.0;
    let sum_safety_score=0;
    let danger_polyline=[];
    let new_Steps=[];
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
        new_Steps.push(step);
        sum_safety_score+=safety_score;
    });
    route.legs[0].steps=new_Steps;
    avg_safety_score=sum_safety_score/route.legs[0].steps.length;
    route.safety_score=avg_safety_score;
    route.danger_polyline=danger_polyline;
    if(avg_safety_score<min_safety_score){
        min_safety_score=avg_safety_score;
        min_safety_node=index;
    }
});
   result.push(routeDetails[min_safety_node])
   return result;
}

// safeRouteJson(routeDetails)


module.exports = {safeRouteJson};