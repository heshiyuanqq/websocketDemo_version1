package com.websocket.web.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.websocket.web.bean.TestSystem;

public interface TestSystemService {

	void saveOrUpdate(TestSystem testSystem);

	List<TestSystem> getVOListBySystemIds(ArrayList<String> systemIds);

	List<TestSystem> getVOListByState(Integer state);

	void updateStateBySystemId(String systemId, Integer newState);

	Map<Integer,List<TestSystem>> getAllAndOrderByState();

	//Map<Integer, Long> getStateCountMap();

	long[] getStateCountList();

	long[] getTypeCountList();

	List<TestSystem> getVOListByTypeId(Integer typeId);

	Map<Integer, List<TestSystem>> getAllAndOrderByTypeId();


}
