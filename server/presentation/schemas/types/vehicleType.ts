import {
    GraphQLBoolean,
    GraphQLFloat,
    GraphQLID,
    GraphQLInt,
    GraphQLNonNull,
    GraphQLObjectType,
    GraphQLString
} from "graphql";
import Vehicle from "../../../domain/entities/vehicle";
import {modelType} from "./modelType";
import ModelController from "../../../domain/controllers/modelController";
import {colorType} from "./colorType";
import ColorController from "../../../domain/controllers/colorController";
import {centerType} from "./centerType";
import CenterController from "../../../domain/controllers/centerController";

const vehicleType = new GraphQLObjectType<Vehicle>({
    name: 'Vehicle',
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        numberPlate: { type: GraphQLNonNull(GraphQLString) },
        nbPlaces: { type: GraphQLNonNull(GraphQLInt) },
        kilometrage: { type: GraphQLNonNull(GraphQLFloat) },
        isAirConditioner: { type: GraphQLNonNull(GraphQLBoolean) },
        amountExcluding: { type: GraphQLFloat },
        maxCharge: { type: GraphQLFloat },
        maxSpeedAllowed: { type: GraphQLFloat },
        model: {
            type: GraphQLNonNull(modelType),
            resolve: (vehicle) => ModelController.getById(vehicle.modelId)
        },
        color: {
            type: GraphQLNonNull(colorType),
            resolve: (vehicle) => ColorController.getById(vehicle.colorId)
        },
        center: {
            type: GraphQLNonNull(centerType),
            resolve: (vehicle) => CenterController.getById(vehicle.centerId)
        }
    },
})

export {vehicleType}
