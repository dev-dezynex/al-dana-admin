// change the domain name if you want
const String domainName = "http://192.168.1.17:4000";

const String apiVersion = "/api/v1/";

const String apiBase = domainName + apiVersion;

const String apiSignin = "${apiBase}users/login";
const String apiSignup = "${apiBase}users/signup";
const String apiReadUser = "${apiBase}users/getProfile";
const String apiUpdateUser = "${apiBase}users/editProfile";
const String apiChangePasswordUser = "${apiBase}users/changePassword";
const String apiListActiveUser = "${apiBase}users/listUsers";
const String apiListInactiveUser = "${apiBase}users/getDeactivateProfiles";
const String apiInactivateUser = "${apiBase}users/deactiveProfile";
const String apiActivateUser = "${apiBase}users/activeProfile";
//customers
const String apiListActiveCustomers = "${apiBase}users/listCustomers";
//file upload
const String apiFileUpload = "${apiBase}users/fileUpload";
//branch
const String apiAddBranch = "${apiBase}users/addServiceStation";
const String apiListBranch = "${apiBase}users/listServiceStation";
const String apiUpdateBranch = "${apiBase}users/editServiceStation";
const String apiDeleteBranch = "${apiBase}users/deleteServiceStation";
//category
const String apiAddCategory = "${apiBase}users/addCategory";
const String apiListCategory = "${apiBase}users/listCategory";
const String apiUpdateCategory = "${apiBase}users/editCategory";
const String apiDeleteCategory = "${apiBase}users/deleteCategory";
//service
const String apiAddService = "${apiBase}users/addService";
const String apiListService = "${apiBase}users/listService";
const String apiUpdateService = "${apiBase}users/editService";
const String apiDeleteService = "${apiBase}users/deleteService";
//car brand
const String apiAddCarBrand = "${apiBase}users/addCarBrand";
const String apiListCarBrand = "${apiBase}users/listCarBrand";
const String apiUpdateCarBrand = "${apiBase}users/editCarBrand";
const String apiDeleteCarBrand = "${apiBase}users/deleteCarBrand";
//car model
const String apiAddCarModel = "${apiBase}users/addCarModel";
const String apiListCarModel = "${apiBase}users/listCarModel";
const String apiUpdateCarModel = "${apiBase}users/editCarModel";
const String apiDeleteCarModel = "${apiBase}users/deleteCarModel";
//variant
const String apiAddCarVariant = "${apiBase}users/addCarVariant";
const String apiListCarVariant = "${apiBase}users/listCarVariant";
const String apiUpdateCarVariant = "${apiBase}users/editCarVariant";
const String apiDeleteCarVariant = "${apiBase}users/deleteCarVariant";
//Banner
const String apiAddBanner = "${apiBase}users/addBanner";
const String apiListBanner = "${apiBase}users/listBanner";
const String apiUpdateBanner = "${apiBase}users/editBanner";
const String apiDeleteBanner = "${apiBase}users/deleteBanner";
//service mode
const String apiAddServiceMode = "${apiBase}users/addServiceMode";
const String apiListServiceMode = "${apiBase}users/listServiceMode";
const String apiUpdateServiceMode = "${apiBase}users/editServiceMode";
const String apiDeleteServiceMode = "${apiBase}users/deleteServiceMode";
//spare category
const String apiAddSpareCategory = "${apiBase}users/addSpareCategory";
const String apiListActiveSpareCategory = "${apiBase}users/listSpareCategory";
const String apiListInactiveSpareCategory =
    "${apiBase}users/listInActivateSpare";
const String apiUpdateSpareCategory = "${apiBase}users/editSpareCategory";
const String apiDeleteSpareCategory = "${apiBase}users/deleteSpareCategory";
const String apiReadSpareCategory = "${apiBase}users/getSpareCategory";
//spare
const String apiAddSpare = "${apiBase}users/addSpare";
const String apiListActiveSpare = "${apiBase}users/listSpare";
const String apiListInactiveSpare = "${apiBase}users/listInActivateSpare";
const String apiUpdateSpare = "${apiBase}users/editSpare";
const String apiDeleteSpare = "${apiBase}users/deleteSpare";
const String apiReadSpare = "${apiBase}users/getSpare";
//spare
const String apiAddPackage = "${apiBase}users/addPackage";
const String apiListActivePackage = "${apiBase}users/listPackage";
const String apiListInactivePackage = "${apiBase}users/listInActivatePackage";
const String apiUpdatePackage = "${apiBase}users/editPackage";
const String apiDeletePackage = "${apiBase}users/deletePackage";
const String apiReadPackage = "${apiBase}users/getPackage";
//time slot
const String apiAddTimeSlot = "${apiBase}users/addTimeSlot";
const String apiListActiveTimeSlot = "${apiBase}users/listTimeSlot";
const String apiListInactiveTimeSlot = "${apiBase}users/listInActivateTimeSlot";
const String apiUpdateTimeSlot = "${apiBase}users/editTimeSlot";
const String apiDeleteTimeSlot = "${apiBase}users/deleteTimeSlot";
const String apiReadTimeSlot = "${apiBase}users/getTimeSlot";
const String  apiListDays = "${apiBase}users/listDays";
//defautl time slot
const String apiGetDefaultTimeSlot = "${apiBase}users/listDefaultTimeSlot?";
//coupons
const String apiListCoupon = "${apiBase}users/listCoupon";
const String apipostCoupon = "${apiBase}users/addCoupon";
//reward
const String apiListReward = "${apiBase}users/listReward";
const String apiPostReward = "${apiBase}users/addReward";
const String apiPutReward = "${apiBase}users/editReward";
