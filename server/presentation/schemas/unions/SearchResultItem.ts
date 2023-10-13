import { GraphQLUnionType } from 'graphql';
import sedanVehicleType from '../types/sedanVehicleType';
import vanVehicleType from '../types/vanVehicleType';
import limousineVehicleType from '../types/limousineVehicleType';
import sportVehicleType from '../types/sportVehicleType';

export default new GraphQLUnionType({
  name: 'SearchResultItem',
  types: () => [sedanVehicleType, vanVehicleType, limousineVehicleType, sportVehicleType],
  resolveType: obj => {
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
  }
});
