import {
    GraphQLBoolean,
    GraphQLFloat,
    GraphQLID,
    GraphQLInt,
    GraphQLNonNull,
    GraphQLObjectType,
    GraphQLString
} from "graphql";
import {modelType} from "./modelType";
import ModelController from "../../../domain/controllers/modelController";
import {colorType} from "./colorType";
import ColorController from "../../../domain/controllers/colorController";
import {centerType} from "./centerType";
import CenterController from "../../../domain/controllers/centerController";
import VehicleController from "../../../domain/controllers/vehicleController";
import {transmissionSystemType} from "./transmissionSystemType";
import vehicleInterface from "../interfaces/Vehicle";

export default new GraphQLObjectType({
    name: 'Limousine',
    interfaces: [vehicleInterface],
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        numberPlate: { type: GraphQLNonNull(GraphQLString) },
        nbPlaces: { type: GraphQLNonNull(GraphQLInt) },
        kilometrage: { type: GraphQLNonNull(GraphQLFloat) },
        isAirConditioner: { type: GraphQLNonNull(GraphQLBoolean) },
        amountExcluding: { type: GraphQLFloat },
        imageUri: { type: GraphQLString },
        transmission: {
            type: GraphQLNonNull(transmissionSystemType),
            resolve: (vehicle) => vehicle.transmissionId
        },
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
        },
        isAvailable: {
            type: GraphQLNonNull(GraphQLBoolean),
            resolve: async (vehicle) => {
                let rent = await VehicleController.getVehicleLastRent(vehicle.id);
                if(rent) {
                    return rent.isFinished();
                }
                return true;
            }
        },
        // Specific class arguments
        length: { type: GraphQLNonNull(GraphQLFloat) }
    }
  });
