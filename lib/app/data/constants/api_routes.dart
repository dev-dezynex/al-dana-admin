// change the domain name if you want
const String domainName = "http://192.168.1.10:3000";

const String apiVersion = "/api/v1/";

const String apiBase = domainName + apiVersion;

const String apiSignin = "${apiBase}superAdmin/login";
const String apiSignup = "${apiBase}superAdmin/signup";
//file upload 
const String apiFileUpload = "${apiBase}superAdmin/fileUpload";
//branch
const String apiAddBranch = "${apiBase}superAdmin/addServiceStation";
const String apiListBranch = "${apiBase}superAdmin/listServiceStation";
const String apiUpdateBranch = "${apiBase}superAdmin/editServiceStation";
const String apiDeleteBranch = "${apiBase}superAdmin/deleteServiceStation";
//category
const String apiAddCategory = "${apiBase}superAdmin/addCategory";
const String apiListCategory = "${apiBase}superAdmin/listCategory";
const String apiUpdateCategory = "${apiBase}superAdmin/editCategory";
const String apiDeleteCategory = "${apiBase}superAdmin/deleteCategory";
//service
const String apiAddService = "${apiBase}superAdmin/addService";
const String apiListService = "${apiBase}superAdmin/listService";
const String apiUpdateService = "${apiBase}superAdmin/editService";
const String apiDeleteService = "${apiBase}superAdmin/deleteService";
//brand
const String apiAddCarBrand = "${apiBase}superAdmin/addCarBrand";
const String apiListCarBrand = "${apiBase}superAdmin/listCarBrand";
const String apiUpdateCarBrand = "${apiBase}superAdmin/editCarBrand";
const String apiDeleteCarBrand = "${apiBase}superAdmin/deleteCarBrand";
//brand
const String apiAddCarModel = "${apiBase}superAdmin/addCarModel";
const String apiListCarModel = "${apiBase}superAdmin/listCarModel";
const String apiUpdateCarModel = "${apiBase}superAdmin/editCarModel";
const String apiDeleteCarModel = "${apiBase}superAdmin/deleteCarModel";
//variant
const String apiAddCarVariant = "${apiBase}superAdmin/addCarVariant";
const String apiListCarVariant = "${apiBase}superAdmin/listCarVariant";
const String apiUpdateCarVariant = "${apiBase}superAdmin/editCarVariant";
const String apiDeleteCarVariant = "${apiBase}superAdmin/deleteCarVariant";
//Banner
const String apiAddBanner = "${apiBase}superAdmin/addBanner";
const String apiListBanner = "${apiBase}superAdmin/listBanner";
const String apiUpdateBanner = "${apiBase}superAdmin/editBanner";
const String apiDeleteBanner = "${apiBase}superAdmin/deleteBanner";