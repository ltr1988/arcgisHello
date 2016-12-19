/*
 * $Revision: 2 $
 * $Date: 2012-11-19 13:02:54 +0800 (周一, 19 十一月 2012) $
 * $Id: javacodetemplate.xml 2 2012-11-19 05:02:54Z wangx $
 * ====================================================================
 * Copyright © 2012 Beijing seeyon software Co..Ltd..All rights reserved.
 *
 * This software is the proprietary information of Beijing seeyon software Co..Ltd.
 * Use is subject to license terms.
 */
package com.seeyon.apps.m1.common.manager.menu.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.seeyon.app.mlogin.manager.MloginManager;
import com.seeyon.apps.collaboration.manager.ColManager;
import com.seeyon.apps.m1.common.bo.menu.MMenuUtils;
import com.seeyon.apps.m1.common.manager.menu.MMenuManager;
import com.seeyon.apps.m1.common.vo.MConstant;
import com.seeyon.apps.m1.common.vo.datatype.MList;
import com.seeyon.apps.m1.common.vo.menu.MMenuItemsCount;
import com.seeyon.apps.m1.login.manager.impl.MLoginManagerImpl;
import com.seeyon.apps.m1.meeting.manager.MMeetingManager;
import com.seeyon.ctp.common.AppContext;
import com.seeyon.ctp.common.exceptions.BusinessException;
import com.seeyon.v3x.edoc.manager.EdocListManager;

public class MMenuManagerImpl implements MMenuManager {
	private static final Log log = LogFactory.getLog(MMenuManagerImpl.class);
	private ColManager colManager;
	private EdocListManager edocListManager;
	private MMeetingManager mMeetingManager;
	private MloginManager mloginManager = (MloginManager) AppContext
			.getBean("mloginManager");

	@Override
	public MList<MMenuItemsCount> getMenusCount() throws BusinessException {
		MList<MMenuItemsCount> mlist = new MList<MMenuItemsCount>();
		List<MMenuItemsCount> list = new ArrayList<MMenuItemsCount>();
		MMenuItemsCount mcount = new MMenuItemsCount();
		// 获取协同未读数
		mcount.setModuleType(MConstant.C_iModuleType_Collaboration);
		mcount.setCount(MMenuUtils.getColCount(colManager));
		list.add(mcount);
		// C_menu_log.info(
		// "**********************************协同未读数*************************" +
		// mcount.getCount());
		// 获取公文未读数
		mcount = new MMenuItemsCount();
		mcount.setModuleType(MConstant.C_iModuleType_EDoc);
		mcount.setCount(MMenuUtils.getEdocCount(edocListManager));
		list.add(mcount);
		// C_menu_log.info(
		// "**********************************公文未读数*************************" +
		// mcount.getCount());
		// 获取会议未读数
		if (mMeetingManager != null) {
			mcount = new MMenuItemsCount();
			mcount.setModuleType(MConstant.C_iModuleType_Meeting);
			mcount.setCount(MMenuUtils.getMMeetingCount(mMeetingManager));
			list.add(mcount);
		}

		try {
			// 获取到32位码
			String ssoTicket = mloginManager.getDataByLoginname(AppContext
					.currentUserLoginName());
			if (ssoTicket != null) {
				InputStream input = null;
				input = MLoginManagerImpl.class.getClassLoader()
						.getResourceAsStream("getMessage.properties");
				Properties config = new Properties();
				config.load(input);
				String app1Url = StringUtils.trim((String) config
						.get("app1Url"));
				String app2Url = StringUtils.trim((String) config
						.get("app2Url"));
				String app3Url = StringUtils.trim((String) config
						.get("app3Url"));

				mcount = new MMenuItemsCount();
				mcount.setModuleType(2001);
				if (app1Url != null && app1Url.length() > 10) {
					if (app1Url.indexOf("?") == -1) {
						app1Url = app1Url + "?ticket=" + ssoTicket;
					} else {
						app1Url = app1Url + "&ticket=" + ssoTicket;
					}
				}
				mcount.setCount(getNum(app1Url));
				list.add(mcount);

				mcount = new MMenuItemsCount();
				mcount.setModuleType(2002);
				if (app2Url != null && app2Url.length() > 10) {
					if (app2Url.indexOf("?") == -1) {
						app2Url = app2Url + "?ticket=" + ssoTicket;
					} else {
						app2Url = app2Url + "&ticket=" + ssoTicket;
					}
				}
				mcount.setCount(getNum(app2Url));
				list.add(mcount);

				mcount = new MMenuItemsCount();
				mcount.setModuleType(2003);
				if (app3Url != null && app3Url.length() > 10) {
					if (app3Url.indexOf("?") == -1) {
						app3Url = app3Url + "?ticket=" + ssoTicket;
					} else {
						app3Url = app3Url + "&ticket=" + ssoTicket;
					}
				}
				mcount.setCount(getNum(app3Url));
				list.add(mcount);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		mlist.setValue(list);
		return mlist;
	}

	/**
	 * 取得HttpURLConnection，并设置参数
	 * 
	 * @param in
	 * @param urlPath
	 * @param cookies
	 * @return
	 * @throws Exception
	 */
	private int getNum(String urlPath) {
		if (urlPath == null || urlPath.length() < 10) {
			return 0;
		}
		HttpURLConnection httpURLConnection = null;
		String resulet = "";
		try {
			URL url = new URL(urlPath);// 提交地址
			httpURLConnection = (HttpURLConnection) url.openConnection();
			// 是否有
			httpURLConnection.setDoOutput(true);// 打开写入属性
			httpURLConnection.setRequestMethod("get");// 设置提交方法
			httpURLConnection.setUseCaches(false);
			httpURLConnection.setRequestProperty("Content-Type",
					"text/xml; charset=UTF-8");
			httpURLConnection.setDoInput(true);// 打开读取属性
			httpURLConnection.setConnectTimeout(40000); // 设置连接超时时间
			httpURLConnection.setReadTimeout(40000);// 设置读取超时时间
			httpURLConnection.connect();
			if (httpURLConnection.getResponseCode() == 200) {
				InputStream in = httpURLConnection.getInputStream();
				byte[] b = new byte[1024];
				int lent = 0;
				while ((lent = in.read(b)) != -1) {
					resulet = resulet + new String(b, 0, lent);
				}
				in.close();
			}
			return Integer.valueOf(resulet);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			httpURLConnection.disconnect();
		}
		return 0;

	}

	/**
	 * 获取协同插件管理器
	 * 
	 * @return 返回协同插件管理器
	 */
	public ColManager getColManager() {
		return colManager;
	}

	/**
	 * 设置协同插件管理器
	 * 
	 * @param colManager
	 *            协同插件管理器
	 */
	public void setColManager(ColManager colManager) {
		this.colManager = colManager;
	}

	/**
	 * 获取公文列表管理器
	 * 
	 * @return edocListManager 公文列表管理器
	 */
	public EdocListManager getEdocListManager() {
		return edocListManager;
	}

	/**
	 * 设置公文列表管理器
	 * 
	 * @param edocListManager
	 *            公文列表管理器
	 */
	public void setEdocListManager(EdocListManager edocListManager) {
		this.edocListManager = edocListManager;
	}

	/**
	 * 获取M1会议管理器
	 * 
	 * @return mMeetingManager M1会议管理器
	 */
	public MMeetingManager getmMeetingManager() {
		return mMeetingManager;
	}

	/**
	 * 设置M1会议管理器
	 * 
	 * @param mMeetingManager
	 *            M1会议管理器
	 */
	public void setmMeetingManager(MMeetingManager mMeetingManager) {
		this.mMeetingManager = mMeetingManager;
	}
}
