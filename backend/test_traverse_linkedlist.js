const { routeArrays, coordinatesMap,endLocation,routeDetails } = require('./test_linkedlist');
const data = require('./data/data.json');

let distance_sum = 0;
let time_sum = 0;
let final_polyline = "";
let final_steps=[];
let result=routeDetails[0];
// result.legs[0].steps=[];
// result.overview_polyline.points="";
// result.dangerPolylines=[];

function unsafe(node) {
    //check if node is in unsafe location
    console.log("node: ",node)
    let min_distance=1000000000, safety_score=0;
    data.forEach((element) => {
        // calculate distance between node and element
        let distance = Math.sqrt(Math.pow(node.lat - element.lat, 2) + Math.pow(node.lng - element.lng, 2));
        if(distance<min_distance){
            min_distance=distance;
            safety_score=element.properties.mag;
        }
    });
    if(safety_score>=3){
        return true;
    }
    return false;
}

function traverse(routeArrays, coordinatesMap, endLocation) {
    // console.log(routeArrays.size)
    console.log("end: ",endLocation)
    let count=0;
    for (let [key,value] of coordinatesMap) {
        if(value.length == routeArrays.size) {
            count++;
            routeArrays.get(0)[count]
            if(unsafe(key)){
                console.log("Warning: Unsafe route")
            }
        }
        else 
         break
    }
    let curr_array = 0
    let curr_index=count
    let curr_node = routeArrays.get(curr_array)[curr_index].stepStartLocation
    let steps=0
    console.log(curr_node)
    while(curr_node.lat!=endLocation.lat && curr_node.lng!=endLocation.lng){
        if(unsafe(curr_node)){
            //from here
            curr_array++;
            if(curr_array==routeArrays.size){
                console.log("Warning: Unsafe route")
                curr_array=0;
                curr_index++;
            }
        }
        else{
          curr_index++;
        }
        curr_node=routeArrays.get(curr_array)[curr_index].stepStartLocation
        console.log(curr_node)
        steps++
    }
}

traverse(routeArrays, coordinatesMap,endLocation)