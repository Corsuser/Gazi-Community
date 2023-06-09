package com.team.devdungeon.service;

import com.team.devdungeon.dao.StoreDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.*;

import static com.team.devdungeon.util.SFTPFileUtil.channelSftp;
import static com.team.devdungeon.util.SFTPFileUtil.remotePath;

@RequiredArgsConstructor
@Service
public class StoreServiceImpl implements StoreService {

    private final StoreDAO storeDAO;

    @Override
    public List<Map<String, Object>> iconList(Map<String, Object> pages) {
        List<Map<String, Object>> result = storeDAO.iconList(pages);

        InputStream inputStream = null;
        ByteArrayOutputStream baos = null;
        byte[] buffer = null;
        byte[] imageData = null;

        List<Map<String, Object>> resutList = new ArrayList<>();

        for(Map<String, Object> map : result) {
            try {
                String emo_img_name = (String) map.get("emo_img_name");
                String emo_img_extension = (String) map.get("emo_img_extension");

                inputStream = channelSftp.get(remotePath + emo_img_name + "." + emo_img_extension);
                baos = new ByteArrayOutputStream();
                buffer = new byte[1024 * 8];
                int len;
                while ((len = inputStream.read(buffer)) > -1) {
                    baos.write(buffer, 0, len);
                }
                baos.flush();
                imageData = baos.toByteArray();

                String icon_image = Base64.getEncoder().encodeToString(imageData);
                map.put("icon_image", icon_image);
            } catch (Exception e) {
                System.out.println("아이콘 이미지 로딩중 에러 발생");
            }
            resutList.add(map);
        }

        return result;
    }

    @Override
    public int iconListCount(Map<String, Object> pages) {
        return storeDAO.iconListCount(pages);
    }

    @Override
    public int selectProductLog(String userId, String[] shoppingBag) {
        Map<String, Object> cartInfo = new HashMap<>();
        List<String> cart = new ArrayList<>();

        for(String ele : shoppingBag) {
            cart.add(ele);
        }

        cartInfo.put("member_id", userId);
        cartInfo.put("cart", cart);

        return storeDAO.selectProductLog(cartInfo);
    }

    @Override
    public int shoppingBagInsert(String userId, String[] shoppingBag, String sellType) {
        Map<String, Object> cartInfo = new HashMap<>();
        List<String> cart = new ArrayList<>();

        for(String ele : shoppingBag) {
            cart.add(ele);
        }

        cartInfo.put("member_id", userId);
        cartInfo.put("cart", cart);
        cartInfo.put("sell_type", sellType);

        return storeDAO.shoppingBagInsert(cartInfo);
    }

    @Override
    public List<Map<String, Object>> selectPayShoppingBag(Object memberId, String view_type) {
        Map<String, Object> cartInfo = new HashMap<>();
        cartInfo.put("member_id", memberId);
        cartInfo.put("view_type", view_type);
        List<Map<String, Object>> cart = storeDAO.selectPayShoppingBag(cartInfo);

        InputStream inputStream = null;
        ByteArrayOutputStream baos = null;
        byte[] buffer = null;
        byte[] imageData = null;

        List<Map<String, Object>> result = new ArrayList<>();

        for(Map<String, Object> map : cart) {
            try {
                String emo_img_name = (String) map.get("emo_img_name");
                String emo_img_extension = (String) map.get("emo_img_extension");

                inputStream = channelSftp.get(remotePath + emo_img_name + "." + emo_img_extension);
                baos = new ByteArrayOutputStream();
                buffer = new byte[1024 * 8];
                int len;
                while ((len = inputStream.read(buffer)) > -1) {
                    baos.write(buffer, 0, len);
                }
                baos.flush();
                imageData = baos.toByteArray();

                String icon_image = Base64.getEncoder().encodeToString(imageData);
                map.put("icon_image", icon_image);
            } catch (Exception e) {
                System.out.println("아이콘 이미지 로딩중 에러 발생");
            }
            result.add(map);
        }

        return result;
    }

    @Override
    public List<Map<String, Object>> selectGiftShoppingBag(Object memberId) {
        return storeDAO.selectGiftShoppingBag(memberId);
    }

    @Override
    public List<Map<String, Object>> couponList(String member_id) {
        return storeDAO.couponList(member_id);
    }

    @Override
    public int checkPoint(Object memberId) {
        return storeDAO.checkPoint(memberId);
    }

    @Override
    public List<Map<String, Object>> checkProductCount(Object memberId) {
        return storeDAO.checkProductCount(memberId);
    }

    @Override
    public void deleteCart(Map<String, Object> deleteCartList, Object memberId) {
        Map<String, Object> info = new HashMap<>();
        info.put("product_no", deleteCartList);
        info.put("member_id", memberId);
        storeDAO.deleteCart(info);
    }

    @Override
    public void deleteCartOne(String userId, Integer product_no, String sellType) {
        Map<String, Object> cartInfo = new HashMap<>();
        cartInfo.put("member_id", userId);
        cartInfo.put("product_no", product_no);
        cartInfo.put("type", sellType);

        System.out.println(cartInfo);

        storeDAO.deleteCartOne(cartInfo);
    }

    @Override
    public int payProduct(int resultPrice, Object memberId, String pay_type, Integer coupon_no) {
        Map<String, Object> payInfo = new HashMap<>();
        payInfo.put("pay_price", resultPrice);
        payInfo.put("member_id", memberId);
        payInfo.put("view_type", pay_type);
        payInfo.put("coupon_no", coupon_no);
        return storeDAO.payProduct(payInfo);
    }


}
