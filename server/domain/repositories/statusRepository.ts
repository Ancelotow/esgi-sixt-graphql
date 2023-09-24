import Status from "../entities/status";

interface StatusRepository {
    getAll(): Promise<Status[]>;
}

export default StatusRepository;
