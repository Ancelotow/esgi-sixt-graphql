import {GraphQLEnumType, GraphQLID, GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import Status from "../../../domain/entities/status";

const statusType = new GraphQLEnumType({
    name: 'Status',
    values: {
        IN_PROCESS: { value: 1 },
        WAITING_PAYMENT: { value: 2 },
        RENTED: { value: 3 },
        CANCELLED: { value: 4 },
        VEHICLE_RETURNED: { value: 5 },
        RENT_FINISHED: { value: 6 },
    },
})

export {statusType}
