class GQLMutation {
  // Mutation for generating OTP
  static String generateOTPQuery = r"""
  mutation generateOTP($source: String!, $source_type: Int!) {
    generateOTP(source: $source, source_type: $source_type) {
      id
    }
  }
  """;

  // Mutation for verifying OTP
  static String verifyOtpQuery = r"""
  mutation verifyOTP(
    $source: String!, $source_type: Int!, $OTP: Int!
  ) 
  {
    verifyOTP(
      source: $source, source_type: $source_type, OTP: $OTP
    ) 
    {
      id
      firstname
      lastname
      email
      is_verified_mobile
    }
  }
  """;

  // Mutation for updating profile
  static const String updateProfileQuery = r"""
  mutation updateCustomer(
    $id: Int!
    $firstname: String!
    $lastname: String!
    $email: String!
    $mobile: String!
    $status: Int!
    $customer_group_id: Int!
  ) 
  {
    updateCustomer(
      id: $id
      firstname: $firstname
      lastname: $lastname
      email: $email
      mobile: $mobile
      status: $status
      customer_group_id: $customer_group_id
    ) 
    {
      id
      firstname
      lastname
      email
    }
  }
  """;

  // Mutation for adding to favorites
  static const String addtoFavQuery = r"""
  mutation addProductInFavourite($product_id: Int!, $customer_id: Int) {
    addProductInFavourite(product_id: $product_id, customer_id: $customer_id) {
      id
    }
  }
  """;

  // Mutation for creating a customer profile
  static const String createProfileQuery = r"""
  mutation signupCustomer($username: String!, $email: String!, $mobile: String!, $OTP: Int!) {
    signupCustomer(username: $username, email: $email, mobile: $mobile, OTP: $OTP) {
      id
      firstname
      lastname
      email
      mobile
    }
  }
  """;

  // Mutation for placing an order
  static String addOrder = r"""
  mutation placeOrder(
    $customerID: Int!, 
    $products: [OrderProductInput!]!, 
    $deliveryDate: String!, 
    $shippingMethod: String!, 
    $total: Float, 
    $paymentMethod: String!, 
    $deliveryTime: String, 
    $shippingLat: String, 
    $shippingLng: String
  ) {
    addOrder(
      order: {
        id: 123
        shipping_address_1: "Fakhri Trade Center"
        shipping_latitude: $shippingLat
        shipping_longitude: $shippingLng
        invoice_id: 0
        invoice_prefix: "OI"
        customer_id: $customerID
        shipping_address_id: 108
        payment_address_id: 108
        language_id: 1
        currency_id: 5
        currency: "AED"
        value: 0
        coupon_id: 0
        shipping_method: $shippingMethod
        payment_method: $paymentMethod
        delivery_date: $deliveryDate
        time_slot: $deliveryTime
        total: $total
      }
      products: $products
      total_tax_inclusive: 9.05
      discount: 5
    ) {
      id
      shipping_address_1
      order_products {
        total
        name
        id
        product_id
        product {
          price
          image
        }
      }
    }
  }
  """;

  // Mutation for applying a coupon
  static String coupon = r"""
  mutation applyCoupon(
    $products: [ProductCouponInput!]!, 
    $couponCode: String!, 
    $customerID: Int!, 
    $orderTotal: Float!
  ) {
    applyCoupon(
      coupon_code: $couponCode
      customer_id: $customerID
      order_total: $orderTotal
      products: $products
    ) {
      id
      discount
    }
  }
  """;

  // Mutation for adding an address
  static String addAddress = r"""
  mutation addAddress($customerID: Int!, $lat: String, $lng: String, $addressLine: String!) {
    addAddress(
      customer_id: $customerID
      address_type: 1
      firstname: "Syed"
      address_1: $addressLine
      city: ""
      latitude: $lat
      longitude: $lng
      house_building_no: ""
      business_premises: ""
    ) {
      id
      latitude
      longitude
    }
  }
  """;
}