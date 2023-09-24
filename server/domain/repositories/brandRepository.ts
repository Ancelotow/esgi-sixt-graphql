import Brand from "../entities/brand";

interface BrandRepository {
    getAll(): Promise<Brand[]>;
}

export default BrandRepository;
