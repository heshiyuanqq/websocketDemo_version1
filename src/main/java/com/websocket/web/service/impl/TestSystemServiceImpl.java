package com.websocket.web.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.websocket.web.bean.TestSystem;
import com.websocket.web.dao.TestSystemMapper;
import com.websocket.web.service.TestSystemService;
import com.websocket.web.utils.Constant;
@Service(value="testSystemServiceImpl")
public class TestSystemServiceImpl implements TestSystemService{

	@Autowired
	private TestSystemMapper testSystemMapper;
	
	
	@Override
	public void saveOrUpdate(TestSystem testSystem) {
			HashMap<String, Object> params = new HashMap<String, Object>();
			params.put("systemId", testSystem.getSystemId());
			
			List<TestSystem> results=testSystemMapper.getListByConditions(params);
			if(results==null||results.size()<1){//save
				testSystemMapper.save(testSystem);
			}else{//update
				testSystemMapper.updateBySystemId(testSystem);
			}
	}


	@Override
	public List<TestSystem> getVOListBySystemIds(ArrayList<String> systemIds) {
		List<TestSystem> testSystemList = testSystemMapper.getListBySystemIds(systemIds);
		if(testSystemList!=null&&testSystemList.size()>0){
			for (TestSystem testSystem : testSystemList) {
					setTypeName(testSystem);
			}
		}
		
		return  testSystemList;
	}


	private void setTypeName(TestSystem testSystem) {
			switch (testSystem.getTypeId()) {
				case 0:
					testSystem.setTypeName("LET基站测试cms500");
					break;
				case 1:
					testSystem.setTypeName("LET基站测试切换箱");
					break;
				case 2:
					testSystem.setTypeName("LET基站可靠性测试-协议4.0");
					break;
				case 3:
					testSystem.setTypeName("LET基站实验室测试-协议4.0");
					break;
				case 4:
					testSystem.setTypeName("Femato基站射频测试系统");
					break;
				case 5:
					testSystem.setTypeName("无源器件S参数测试系统");
					break;
			}
	}


	@Override
	public List<TestSystem> getVOListByState(Integer state) {
			List<TestSystem> list = testSystemMapper.getListByState(state);
			if(list!=null&&list.size()>0){
				for (TestSystem testSystem : list) {
						setTypeName(testSystem);
				}
			}
			
			return  list;
	}


	@Override
	public void updateStateBySystemId(String systemId, Integer newState)  {
				TestSystem testSystem=new TestSystem();
				testSystem.setSystemId(systemId);
				testSystem.setState(newState);
				testSystemMapper.updateBySystemId(testSystem);
	}


	@Override
	public Map<Integer,List<TestSystem>> getAllAndOrderByState() {
				HashMap<String, Object> params = new HashMap<String, Object>();
				List<TestSystem> list = testSystemMapper.getListByConditions(params);
				if(list!=null&&list.size()>0){
						Map<Integer,List<TestSystem>> resultMap=new HashMap<Integer, List<TestSystem>>();
						for (TestSystem testSystem : list) {
								setTypeName(testSystem);
								List<TestSystem> existList = resultMap.get(testSystem.getState());
								if(existList==null){
										existList=new ArrayList<TestSystem>();
										resultMap.put(testSystem.getState(), existList);
								}
								existList.add(testSystem);
						}
						return resultMap;
				}
				return null;
	}

	/**
	 * []角标0-6即为状态对应数字，角标处值为正处于该状态下的测试系统的数量
	 */
	@Override
	public long[] getStateCountList() {
			List<Map<String, Object>> stateCountMapList = testSystemMapper.getStateCountMap();
			long[] arr=new long[Constant.stateSum];
			if(stateCountMapList!=null&&stateCountMapList.size()>0){
					for(int state=0;state<arr.length;state++){
							for (Map<String,Object> map: stateCountMapList) {
								int currState = (int) map.get("state");
								if(currState==state){
									long stateCount = (long) map.get("stateCount");
									arr[state]=Integer.valueOf(stateCount+"");
									break;
								}
							}
					}
			}
			return arr;
	}


	@Override
	public long[] getTypeCountList() {
			List<Map<String, Object>> typeCountMapList = testSystemMapper.getTypeCountMap();
			long[] arr=new long[Constant.typeSum];
			if(typeCountMapList!=null&&typeCountMapList.size()>0){
					for(int type=0;type<arr.length;type++){
							for (Map<String,Object> map: typeCountMapList) {
								int currType = (int) map.get("typeId");
								if(type==currType){
									long typeCount = (long) map.get("typeCount");
									arr[type]=Integer.valueOf(typeCount+"");
									break;
								}
							}
					}
			}
			return arr;
	}


	@Override
	public List<TestSystem> getVOListByTypeId(Integer typeId) {
		List<TestSystem> list = testSystemMapper.getListByTypeId(typeId);
		if(list!=null&&list.size()>0){
			for (TestSystem testSystem : list) {
					setTypeName(testSystem);
			}
		}
		return  list;
	}


	@Override
	public Map<Integer, List<TestSystem>> getAllAndOrderByTypeId() {
			HashMap<String, Object> params = new HashMap<String, Object>();
			List<TestSystem> list = testSystemMapper.getListByConditions(params);
			if(list!=null&&list.size()>0){
					Map<Integer,List<TestSystem>> resultMap=new HashMap<Integer, List<TestSystem>>();
					for (TestSystem testSystem : list) {
							setTypeName(testSystem);
							List<TestSystem> existList = resultMap.get(testSystem.getTypeId());
							if(existList==null){
									existList=new ArrayList<TestSystem>();
									resultMap.put(testSystem.getTypeId(), existList);
							}
							existList.add(testSystem);
					}
					return resultMap;
			}
			return null;
	}
	
}
