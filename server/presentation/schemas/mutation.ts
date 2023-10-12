import {GraphQLObjectType} from "graphql";
import {loginType} from "./mutators/login";
import {addUserType} from "./mutators/addUser";
import {updateVehicleType} from "./mutators/updateVehicle";
import {updateRentStatusType} from "./mutators/updateRentStatus";
import { createRentType } from "./mutators/createRent";
import { addVehicleType } from "./mutators/addVehicle";
import { addCenterType } from "./mutators/addCenter";
import { deleteCenterType } from "./mutators/deleteCenter";

export default new GraphQLObjectType({
    name: 'Mutation',
    fields: {
        login: loginType,
        addUser: addUserType,
        updateVehicle: updateVehicleType,
        addVehicle: addVehicleType,
        updateRentStatus: updateRentStatusType,
        createRent: createRentType,
        addCenter: addCenterType,
        deleteCenter: deleteCenterType,
    }
})
