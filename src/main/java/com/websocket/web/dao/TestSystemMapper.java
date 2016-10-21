package com.websocket.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.websocket.web.bean.TestSystem;
import com.websocket.web.utils.IbatisMapper;


@IbatisMapper
public interface TestSystemMapper {

	void save(TestSystem testSystem);

	void updateById(TestSystem testSystem);

	void updateBySystemId(TestSystem testSystem);

	List<TestSystem> getListByConditions(HashMap<String, Object> params);

	List<TestSystem> getListBySystemIds(ArrayList<String> systemIds);

	List<TestSystem> getListByState(Integer state);

	List<Map<String, Object>> getStateCountMap();

	List<Map<String, Object>> getTypeCountMap();

	List<TestSystem> getListByTypeId(Integer typeId);
}
