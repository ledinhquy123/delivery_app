// ignore_for_file: constant_identifier_names

const ROOT_URL = 'http://192.168.1.8:8000';
const API_URL = '$ROOT_URL/api';

//! LOGIN_URL
const LOGIN_URL = '$API_URL/auth/login';

//! REGISTER_URL
const REGISTER_URL = '$API_URL/auth/users/register';

//! DRIVER_URL
const GET_DRIVER_LIST = '$API_URL/users/drivers';

//! USER_URL
const ACTIVE_USER = '$API_URL/users'; // PUT(ADD USER ID)
const UPDATE_PROFILE = '$API_URL/users'; //http://192.168.1.5:8000/api/users/1
const LOGOUT_URL = '$API_URL/auth/users/logout';
const USER_SEND_MESSAGE_URL = '$API_URL/users/chats'; // POST http://192.168.1.5:8000/api/users/chats
const GET_USER_NOTIFICATIONS = '$API_URL/notifications?guard='; // http://192.168.1.5:8000/api/notifications
const GET_INCOME_STATISTIC = '$API_URL/users/income-statistic-user?type='; //http://192.168.1.5:8000/api/users/income-statistic-user?id=1&type=month
const RATING_DRIVER = '$API_URL/users/orders'; //http://192.168.1.5:8000/api/users/orders/83

//! ORDER_URL
const PLACE_AN_ORDER_URL = '$API_URL/users/orders'; // POST
const GET_ORDER_LIST = '$API_URL/users/orders'; // GET http://192.168.1.5:8000/api/users/orders?id=5&guard=user
const GET_SINGLE_ORDER = '$API_URL/users/orders'; // GET http://192.168.1.5:8000/api/users/orders/70

//! CHATS API
const GET_MESSAGES_URL = '$API_URL/chats'; // GET (INSER ORDER ID)