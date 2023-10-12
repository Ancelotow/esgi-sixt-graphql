import query from "./query";
import {GraphQLSchema} from "graphql";
import mutation from "./mutation";
import limousineVehicleType from "./types/limousineVehicleType";
import sedanVehicleType from "./types/sedanVehicleType";
import sportVehicleType from "./types/sportVehicleType";
import vanVehicleType from "./types/vanVehicleType";

export default new GraphQLSchema({ 
    query: query, 
    mutation: mutation,
    types: [limousineVehicleType, sedanVehicleType, sportVehicleType, vanVehicleType]
});
