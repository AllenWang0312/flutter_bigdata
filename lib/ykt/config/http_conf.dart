const base_url = 'http://api.9first.com//';

const servicePath = {
  //post
  'tokenLogin': base_url + 'mv2/user/index/login-info',
  'accountLogin': base_url + 'authorization/client/login',
  'getCertListForLearn': base_url + 'mv2/user/course/cert-list',
  'getCourseLearnGson': base_url + 'mv2/user/course/learn-course',
  //get
  'getBannerData': base_url + 'mv2/home/topad',
  'getUserInfo': base_url + 'mv2/user/info/detail',
  'getClasses': base_url + 'mv2/cert/class',
  'getClassList': base_url + 'mv2/cert/list',
  'getCertDetail': base_url + 'mv2/cert/detail'
//  'getUserInfo':base_url+'mv2/user/info/detail',
//  'getUserInfo':base_url+'mv2/user/info/detail',
};

const h5_host = "https://special.9first.com";
const know_more = h5_host + "/special/9first_app/h5/more/";
