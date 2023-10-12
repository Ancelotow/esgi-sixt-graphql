import {
    GraphQLBoolean,
    GraphQLFloat,
    GraphQLID,
    GraphQLInt,
    GraphQLInterfaceType,
    GraphQLNonNull,
    GraphQLString
} from "graphql";
import {modelType} from "../types/modelType";
import ModelController from "../../../domain/controllers/modelController";
import {colorType} from "../types/colorType";
import ColorController from "../../../domain/controllers/colorController";
import {centerType} from "../types/centerType";
import CenterController from "../../../domain/controllers/centerController";
import VehicleController from "../../../domain/controllers/vehicleController";
import {transmissionSystemType} from "../types/transmissionSystemType";

export const resolveType = (obj: { length?: number; maxCharge?: number, power?: number }) => {
    if (obj.length) {
      return 'Limousine';
    }
    if (obj.maxCharge) {
      return 'Van';
    }
    if (obj.power) {
        return 'SportCar';
      }
    return 'Sedan';
  };
  
  const vehicleInterface: GraphQLInterfaceType = new GraphQLInterfaceType({
    name: 'Vehicle',
    resolveType,
    fields: () => ({
      id: { type: GraphQLNonNull(GraphQLID) },
      numberPlate: { type: GraphQLNonNull(GraphQLString) },
      nbPlaces: { type: GraphQLNonNull(GraphQLInt) },
      kilometrage: { type: GraphQLNonNull(GraphQLFloat) },
      isAirConditioner: { type: GraphQLNonNull(GraphQLBoolean) },
      amountExcluding: { type: GraphQLFloat },
      /*maxCharge: { type: GraphQLFloat },
      maxSpeedAllowed: { type: GraphQLFloat },*/
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
      }
    })
  });

export default vehicleInterface;
